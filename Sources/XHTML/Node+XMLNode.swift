/* *************************************************************************************************
 Node+XMLNode.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

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
        if attribute.name?.isEmpty == true {
          self[.defaultNamespace] = attribute.stringValue
        } else if let name = attribute.name.flatMap(NoncolonizedName.init(_:)) {
          self[.userDefinedNamespace(name)] = attribute.stringValue
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
  public convenience init?(_ xmlNode: XMLNode) {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if os(macOS) || swift(>=5.1)
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
  public convenience init?(_ xmlNode: XMLNode) {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if os(macOS) || swift(>=5.1)
    guard
      xmlNode.kind == .processingInstruction,
      let target = xmlNode.name.flatMap(NoncolonizedName.init(_:))
    else {
      return nil
    }
    self.init(target: target, content: xmlNode.stringValue)
    #else
    class _Delegate: NSObject, XMLParserDelegate {
      var pi: ProcessingInstruction!
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
    parser.parse()
    self.init(target: delegate.pi.target, content: delegate.pi.content)
    #endif
  }
}
