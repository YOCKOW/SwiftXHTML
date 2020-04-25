/* *************************************************************************************************
 Parser.swift
   © 2019-2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
import yExtensions

extension Element {
  fileprivate func _trimTexts() -> Void {
    for child in self.children {
      switch child {
      case let text as Text:
        text.text = text.text.trimmingUnicodeScalars(in:.xmlWhitespaces)
      case let element as Element:
        element._trimTexts()
      default:
        break
      }
    }
  }
}

/// The workaround for [SR-10157](https://bugs.swift.org/browse/SR-10157)
private func _swapElementName(_ name:String) -> String {
  #if os(Linux) && compiler(<5.1)
  let splitted = name.splitOnce(separator:":")
  if let originalPrefix = splitted.1 {
    return "\(originalPrefix):\(splitted.0)"
  }
  #endif
  return name
}

open class Parser: NSObject, XMLParserDelegate {
  public enum Error: Swift.Error, Equatable {
    case xmlError(XMLParser.ErrorCode)
    case rootElementIsNotHTML
    // case duplicatedRootElement // Parser Fails
    // case misplacedCDATA // Parser Fails
    case unexpectedError
  }
  
  private var _data: Data
  
  private var _error: Swift.Error? = nil
  
  private var _prolog: Document.Prolog
  private var _document: Document? = nil
  private var _processingElement: Element? = nil
  
  private init(_ data:Data) {
    self._data = data
    
    let xhtmlInfo = self._data.xhtmlInfo
    self._prolog = Document.Prolog(
      xmlVersion:xhtmlInfo.xmlVersion ?? "1.0",
      stringEncoding:xhtmlInfo.stringEncoding ?? .utf8,
      version:xhtmlInfo.version ?? .latest,
      miscellanies: []
    )
  }
  
  public static func parse(_ data:Data) throws -> Document {
    let xmlParser = XMLParser(data:data)
    let delegate = Parser(data)
    xmlParser.delegate = delegate
    
    func _throw() throws -> Never {
      if let error = delegate._error { throw error }
      if let error = xmlParser.parserError { throw error }
      throw Error.unexpectedError
    }
    if !xmlParser.parse() { try _throw() }
    guard let document = delegate._document else { try _throw() }
    
    document.rootElement._trimTexts()
    return document
  }
  
  /// `node` must be `Comment` or `ProcessingInstruction`.
  private func _appendMiscellany(_ node:Node) {
    if let document = self._document {
      if let element = self._processingElement {
        element.append(node)
      } else {
        document.miscellanies.append(Miscellany(node)!)
      }
    } else {
      self._prolog.miscellanies.append(Miscellany(node)!)
    }
  }
  
  ///// As `XMLParserDelegate` /////
  
  /// The parser encounters a fatal error.
  public func parser(_ parser: XMLParser, parseErrorOccurred parseError: Swift.Error) {
    let error = parseError as NSError
    if error.domain == XMLParser.errorDomain {
      if error.code == XMLParser.ErrorCode.delegateAbortedParseError.rawValue {
        return
      }
      self._error = Error.xmlError(XMLParser.ErrorCode(rawValue:error.code)!)
    } else {
      self._error = parseError
    }
    parser.abortParsing()
  }
  
  public func parserDidStartDocument(_ parser: XMLParser) {
    precondition(self._document == nil)
  }
  
  public func parser(_ parser: XMLParser, foundComment comment: String) {
    do {
      self._appendMiscellany(try Comment(comment))
    } catch {
      self.parser(parser, parseErrorOccurred: error)
    }
  }
  
  public func parser(_ parser: XMLParser,
                     foundProcessingInstructionWithTarget target: String,
                     data: String?
  ) {
    guard let targetName = NoncolonizedName(target) else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
      return
    }
    
    let pi = ProcessingInstruction(target:targetName, content:data)
    self._appendMiscellany(pi)
  }
  
  public func parser(_ parser: XMLParser,
                     didStartElement elementName: String,
                     namespaceURI: String?,
                     qualifiedName qName: String?,
                     attributes attributeDict: [String: String] = [:]) {
    do {
      let elementName = _swapElementName(elementName)
      guard let tagName = QualifiedName(elementName) else {
        throw Error.xmlError(.invalidCharacterError)
      }
      let attributes = Attributes(attributeDict)
      let element = try Element(_name: tagName, attributes:attributes, parent: self._processingElement)
      
      if element is HTMLElement {
//      guard self._document == nil && self._processingElement == nil else {
//        self.parser(parser, parseErrorOccurred:Error.duplicatedRootElement)
//        return
//      }
        self._document = Document(prolog:self._prolog, rootElement:element as! HTMLElement)
        self._processingElement = element
      } else {
        guard let processingElement = self._processingElement else {
          throw Error.rootElementIsNotHTML
        }
        try processingElement._append(element)
        self._processingElement = element
      }
    } catch {
      self.parser(parser, parseErrorOccurred: error)
    }
  }
  
  public func parser(_ parser: XMLParser,
              didEndElement elementName: String,
              namespaceURI: String?,
              qualifiedName qName: String?)
  {
    let elementName = _swapElementName(elementName)
    guard let tagName = QualifiedName(elementName) else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.invalidCharacterError))
      return
    }
    
    guard self._processingElement?.name == tagName else {
      self.parser(parser, parseErrorOccurred:Error.xmlError(.tagNameMismatchError))
      return
    }
    
    self._processingElement = self._processingElement?.parent
  }
  
  public func parser(_ parser: XMLParser, foundCharacters string: String) {
    do {
      if let processingElement = self._processingElement {
        if case let lastChild as Text = processingElement.children.last, !(lastChild is CDATASection) {
          lastChild.text += string
        } else {
          processingElement.append(try Text(string))
        }
      } else {
        guard string.consists(of: .xmlWhitespaces) else {
          throw Error.xmlError(.invalidCharacterError)
        }
      }
    } catch {
      self.parser(parser, parseErrorOccurred: error)
    }
  }
  
  public func parser(_ parser: XMLParser, foundCDATA CDATABlock: Data) {
    do {
      guard let cdata = String(data: CDATABlock, encoding: self._prolog.stringEncoding) else {
        throw Error.xmlError(.unknownEncodingError)
      }
      let section = try CDATASection(cdata)
      guard let processingElement = self._processingElement else {
        // throw Error.misplacedCDATA
        return
      }
      processingElement.append(section)
    } catch {
      self.parser(parser, parseErrorOccurred: error)
    }
  }
}
