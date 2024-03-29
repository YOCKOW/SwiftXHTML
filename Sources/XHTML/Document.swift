/* *************************************************************************************************
 Document.swift
   © 2019,2023 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import StringComposition
import yExtensions

private func _validateXMLVersion(_ string:String) -> Bool {
  guard string.count >= 3 else { return false }
  guard string.hasPrefix("1.") else { return false }
  guard string[string.index(string.startIndex, offsetBy:2)...].unicodeScalars.allSatisfy({
    ("0"..."9").contains($0)
  }) else {
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
      return self.version._documentType
    }
    
    public var xhtmlString: String {
      return "\(self._xmlDeclaration)\n\(self._documentType)\n\(self.miscellanies.xhtmlString)"
    }

    public var htmlString: String {
      get throws {
        return "\(_documentType)\n\(try miscellanies.htmlString)"
      }
    }
    
    public var prettyXHTMLLines: StringLines {
      var result = StringLines([
        "\(self._xmlDeclaration)",
        "\(self._documentType)",
      ])
      result.append(contentsOf: self.miscellanies.prettyXHTMLLines)
      return result
    }

    public var prettyHTMLLines: StringLines {
      get throws {
        var result = StringLines([
          "\(self._documentType)",
        ])
        result.append(contentsOf: try miscellanies.prettyHTMLLines)
        return result
      }
    }
    
    public func prettyXHTMLString(indent: String.Indent = .default,
                                  newline: Character.Newline = .lineFeed) -> String  {
      var lines = self.prettyXHTMLLines
      lines.indent = indent
      lines.newline = newline
      return lines.description
    }

    public func prettyHTMLString(
      indent: String.Indent = .default,
      newline: Character.Newline = .lineFeed
    ) throws -> String  {
      var lines = try prettyHTMLLines
      lines.indent = indent
      lines.newline = newline
      return lines.description
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
    let head = try! HeadElement(name: "head")
    let body = try! BodyElement(name: "body")
    let html = try! HTMLElement(name: "html", attributes: [:], children: [head, body])
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

  public var htmlString: String {
    get throws {
      return try prolog.htmlString + rootElement.htmlString + miscellanies.htmlString
    }
  }
  
  public var xhtmlData: Data? {
    return self.xhtmlString.data(using:self.prolog.stringEncoding)
  }

  public var htmlData: Data? {
    get throws {
      return try htmlString.data(using: prolog.stringEncoding)
    }
  }
  
  public var prettyXHTMLLines: StringLines {
    var result = self.prolog.prettyXHTMLLines
    result.append(contentsOf: self.rootElement.prettyXHTMLLines)
    result.append(contentsOf: self.miscellanies.prettyXHTMLLines)
    return result
  }

  public var prettyHTMLLines: StringLines {
    get throws {
      var result = try prolog.prettyHTMLLines
      result.append(contentsOf: try rootElement.prettyHTMLLines)
      result.append(contentsOf: try miscellanies.prettyHTMLLines)
      return result
    }
  }
  
  public func prettyXHTMLString(indent: String.Indent = .default,
                                newline: Character.Newline = .lineFeed) -> String {
    return self.prettyXHTMLLines._description(indent: indent, newline: newline)
  }

  public func prettyHTMLString(
    indent: String.Indent = .default,
    newline: Character.Newline = .lineFeed
  ) throws -> String {
    return try prettyHTMLLines._description(indent: indent, newline: newline)
  }
  
  public var prettyXHTMLString: String {
    return self.prettyXHTMLString()
  }

  public var prettyHTMLString: String {
    get throws {
      return try prettyHTMLString()
    }
  }
  
  public var prettyXHTMLData: Data? {
    return self.prettyXHTMLLines.data(using: self.prolog.stringEncoding)
  }

  public var prettyHTMLData: Data? {
    get throws {
      return try prettyHTMLLines.data(using: self.prolog.stringEncoding)
    }
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
        let head = try! HeadElement(name: QualifiedName(prefix: prefix, localName: "head"))
        self.rootElement.append(head)
      }
      if self.rootElement.head!.title == nil {
        let title = try! TitleElement(name: QualifiedName(prefix: prefix, localName: "title"))
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
