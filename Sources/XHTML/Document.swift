/* *************************************************************************************************
 Document.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

import BonaFideCharacterSet
import yExtensions

private func _validateXMLVersion(_ string:String) -> Bool {
  let numbers = UnicodeScalarSet(unicodeScalarsIn:"0"..."9")
  guard string.count >= 3 else { return false }
  guard string.hasPrefix("1.") else { return false }
  guard
    string[string.index(string.startIndex, offsetBy:2)..<string.endIndex].consists(of:numbers) else
  {
    return false
  }
  return true
}

/// Represents the document of XHTML
open class Document {
  public class Prolog {
    public var xmlVersion: String
    public var stringEncoding: String.Encoding
    public var version: Version
    public var miscellanies: [Miscellany]
    
    public init(xmlVersion: String = "1.0",
                stringEncoding: String.Encoding = .utf8,
                version: Version = .v5_2,
                miscellanies: [Miscellany] = [])
    {
      guard _validateXMLVersion(xmlVersion) else { fatalError("Unsupported XML Verion: \(xmlVersion)") }
      self.xmlVersion = xmlVersion
      self.stringEncoding = stringEncoding
      self.version = version
      self.miscellanies = miscellanies
    }
    
    private var _xmlDeclaration: String {
      guard let charset = self.stringEncoding.ianaCharacterSetName else {
        fatalError("Unsupported String Encoding.")
      }
      return "<?xml version=\"\(self.xmlVersion)\" encoding=\"\(charset)\"?>"
    }
    
    private var _documentType: String {
      guard let doctype = self.version._documentType else {
        fatalError("The version of XHTML must be specified.")
      }
      return doctype
    }
    
    public var xhtmlString: String {
      return "\(self._xmlDeclaration)\n\(self._documentType)\n\(self.miscellanies.xhtmlString)"
    }
    
    public var prettyXHTMLString: String {
      return "\(self._xmlDeclaration)\n\(self._documentType)\n\(self.miscellanies.prettyXHTMLString)"
    }
  }
  
  open var prolog: Prolog
  open var rootElement: HTMLElement
  open var miscellanies: [Miscellany] = []
  
  public init(
    prolog:Prolog,
    rootElement:HTMLElement,
    miscellanies: [Miscellany] = []
  ) {
    self.prolog = prolog
    self.rootElement = rootElement
    self.miscellanies = miscellanies
    self.rootElement.document = self
  }
  
  public convenience init(
    xmlVersion:String = "1.0",
    stringEncoding: String.Encoding = .utf8,
    version: Version = .v5_2,
    rootElement: HTMLElement,
    miscellanies: [Miscellany] = []
  ) {
    self.init(prolog:Prolog(xmlVersion:xmlVersion,
                            stringEncoding:stringEncoding,
                            version:version,
                            miscellanies:[]),
              rootElement:rootElement,
              miscellanies:miscellanies)
  }
}

extension Document {
  public static func template(
    xmlVersion: String = "1.0",
    stringEncoding: String.Encoding = .utf8,
    version: Version = .latest,
    author: String? = nil,
    description: String? = nil,
    keywords: [String]? = nil,
    title: String,
    contents: [Node]
    ) -> Document
  {
    let head = HeadElement(name: "head")
    let body = BodyElement(name: "body")
    let html = HTMLElement(name: "html", attributes: [:], children: [head, body])
    let document = Document(xmlVersion: xmlVersion,
                            stringEncoding: stringEncoding,
                            version: version,
                            rootElement: html)
    head.author = author
    head.description = description
    head.keywords = keywords
    body.children = contents
    document.title = title
    return document
  }
}

extension Document {
  public var xhtmlString: String {
    return self.prolog.xhtmlString + self.rootElement.xhtmlString + self.miscellanies.xhtmlString
  }
  
  public var xhtmlData: Data? {
    return self.xhtmlString.data(using:self.prolog.stringEncoding)
  }
  
  public var prettyXHTMLString: String {
    return self.prolog.prettyXHTMLString + self.rootElement.prettyXHTMLString + self.miscellanies.prettyXHTMLString
  }
  
  public var prettyXHTMLData: Data? {
    return self.prettyXHTMLString.data(using:self.prolog.stringEncoding)
  }
}

extension Document {
  public var title: String? {
    get {
      return self.rootElement.head?.title?.title
    }
    set {
      let newTitle = newValue ?? ""
      
      let prefix = self.rootElement.name.prefix
      if self.rootElement.head == nil {
        let head = HeadElement(name: QualifiedName(prefix: prefix, localName: "head"))
        self.rootElement.append(head)
      }
      if self.rootElement.head!.title == nil {
        let title = TitleElement(name: QualifiedName(prefix: prefix, localName: "title"))
        self.rootElement.head!.append(title)
      }
      
      self.rootElement.head!.title!.title = newTitle
    }
  }
}

extension Document {
  /// Returns an instance of `Element` representing the element whose id property matches
  /// the specified `identifier`.
  public func element(for identifier:String) -> Element? {
    return self.rootElement.element(for:identifier)
  }
}
