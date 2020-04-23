/* *************************************************************************************************
 Node+XMLNode.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif

extension Attributes {
  public init?<S>(_ xmlNodes: S) where S: Sequence, S.Element: XMLNode {
    self.init()
    for attribute in xmlNodes {
      let kind = attribute.kind
      switch kind {
      case .attribute:
        if let name = attribute.name.flatMap(AttributeName.init) {
          self[name] = attribute.stringValue
        } else {
          return nil
        }
      case .namespace:
        // Workaround for [SR-10764](https://bugs.swift.org/browse/SR-10764)
        #if canImport(ObjectiveC) || compiler(>=5.1)
        let isDefault: Bool = attribute.name?.isEmpty == true
        #else
        let isDefault: Bool = attribute.name == nil
        #endif
        if isDefault {
          self[.namespaceDeclaration(.default)] = attribute.stringValue
        } else if let name = attribute.name.flatMap(NoncolonizedName.init(_:)) {
          self[.namespaceDeclaration(.namespace(name))] = attribute.stringValue
        } else {
          return nil
        }
      default:
        return nil
      }
    }
  }
  
  public init?(attributesOf xmlElement: XMLElement) {
    var nodes: [XMLNode] = []
    if let attributes = xmlElement.attributes { nodes.append(contentsOf: attributes) }
    if let namespaces = xmlElement.namespaces { nodes.append(contentsOf: namespaces) }
    self.init(nodes)
  }
}

extension Comment {
  internal convenience init?(_xmlNode xmlNode: XMLNode) {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    guard xmlNode.kind == .comment else { return nil }
    self.init(xmlNode.stringValue!)
    #else
    let xmlString = xmlNode.xmlString
    guard xmlString.hasPrefix("<!--") && xmlString.hasSuffix("-->") else { return nil }
    let startIndexOfText = xmlString.index(xmlString.startIndex, offsetBy: 4)
    let endIndexOfText = xmlString.index(xmlString.endIndex, offsetBy: -3)
    self.init(String(xmlString[startIndexOfText..<endIndexOfText]))
    #endif
  }
}

extension ProcessingInstruction {
  internal convenience init?(_xmlNode xmlNode: XMLNode) {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    guard
      xmlNode.kind == .processingInstruction,
      let target = xmlNode.name.flatMap(NoncolonizedName.init(_:))
    else {
      return nil
    }
    self.init(target: target, content: xmlNode.stringValue)
    #else
    class _Delegate: NSObject, XMLParserDelegate {
      var pi: ProcessingInstruction? = nil
      public func parser(_ parser: XMLParser,
                         foundProcessingInstructionWithTarget target: String,
                         data: String?)
      {
        guard let targetName = NoncolonizedName(target) else {
          parser.abortParsing()
          return
        }
        self.pi = ProcessingInstruction(target:targetName, content:data)
      }
    }
    let parser = XMLParser(data: xmlNode.xmlString.data(using: .utf8)!)
    let delegate = _Delegate()
    parser.delegate = delegate
    _ = parser.parse()
    guard let pi = delegate.pi else { return nil }
    self.init(target: pi.target, content: pi.content)
    #endif
  }
}

extension Text {
  internal convenience init?(_xmlNode xmlNode: XMLNode) {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    guard xmlNode.kind == .text, let text = xmlNode.stringValue else { return nil }
    self.init(text)
    #else
    // FIXME
    // I don't know how to determine if it's text or not...
    // There are also bugs: [SR-10759](https://bugs.swift.org/browse/SR-10759),
    // and [SR-10764](https://bugs.swift.org/browse/SR-10764).
    guard xmlNode.name == "text", xmlNode.children == nil else { return nil }
    guard Comment(_xmlNode: xmlNode) == nil else { return nil }
    guard let text = xmlNode.stringValue else { return nil }
    self.init(text)
    #endif
  }
}


private protocol _Node_XMLNode {}
extension Node: _Node_XMLNode {}
extension _Node_XMLNode {
  fileprivate init?(_xmlNode: XMLNode, xhtmlPrefix: QualifiedName.Prefix) {
    // Comment
    if let comment = Comment(_xmlNode: _xmlNode) {
      self = comment as! Self
      return
    }
    
    // ProcessingInstruction
    if let pi = ProcessingInstruction(_xmlNode: _xmlNode) {
      self = pi as! Self
      return
    }
    
    // Text
    if let text = Text(_xmlNode: _xmlNode) {
      self = text as! Self
      return
    }
    
    guard
      case let xmlElement as XMLElement = _xmlNode,
      let name = xmlElement.name.flatMap(QualifiedName.init),
      let attributes = Attributes(attributesOf: xmlElement)
      else { return nil }
    
    guard let element = try? Element(_name: name, attributes: attributes, xhtmlPrefix: xhtmlPrefix) else {
      return nil
    }
    if let children = xmlElement.children {
      for child in children {
        guard let node = Node(child, xhtmlPrefix: xhtmlPrefix) else { return nil }
        element.append(node)
      }
    }
    self = element as! Self
  }
}
extension Node {
  /// Initialize with an instance of `XMLNode`.
  /// You can specify the prefix of XHTML by passing `xhtmlPrefix`.
  public convenience init?(_ xmlNode: XMLNode, xhtmlPrefix: QualifiedName.Prefix = .none) {
    self.init(_xmlNode: xmlNode, xhtmlPrefix: xhtmlPrefix)
  }
}
