/* *************************************************************************************************
 Node+XMLNode.swift
   © 2019-2020,2023 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif

private extension XMLNode {
  var _isAttribute: Bool {
    return self.kind == .attribute
  }
  
  var _isNamespace: Bool {
    return self.kind == .namespace
  }
  
  var _isDefaultNamespace: Bool {
    assert(self._isNamespace, "Check whether this node is namespace or not in advance.")
    
    // Workaround for [SR-10764](https://bugs.swift.org/browse/SR-10764)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    return self.name?.isEmpty == true
    #else
    return self.name == nil
    #endif
  }
  
  var _isComment: Bool {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    return self.kind == .comment
    #else
    let xmlString = self.xmlString
    return xmlString.hasPrefix("<!--") && xmlString.hasSuffix("-->")
    #endif
  }
  
  var _commentText: String {
    assert(self._isComment, "Check whether this node is comment or not in advance.")
    
    #if canImport(ObjectiveC) || compiler(>=5.1)
    return self.stringValue!
    #else
    return String(self.xmlString.dropFirst(4).dropLast(3))
    #endif
  }
  
  var _isProcessingInstruction: Bool {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    return self.kind == .processingInstruction
    #else
    let xmlString = self.xmlString
    return xmlString.hasPrefix("<?") && xmlString.hasSuffix("?>")
    #endif
  }
  
  var _isText: Bool {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    return self.kind == .text
    #else
    // FIXME
    // I don't know how to determine if it's text or not...
    // There are also bugs: [SR-10759](https://bugs.swift.org/browse/SR-10759),
    // and [SR-10764](https://bugs.swift.org/browse/SR-10764).
    return self.name == "text" && self.children == nil && !self._isComment
    #endif
  }
}

extension Attributes {
  /// Initialize with `XMLNode` instances.
  /// Their kinds are expected to be `.attribute` or `.namespace`.
  public init<S>(_ xmlNodes: S) throws where S: Sequence, S.Element: XMLNode {
    self.init()
    for node in xmlNodes {
      if node._isAttribute {
        guard let name = node.name.flatMap(AttributeName.init) else {
          throw NodeError.invalidAttributeName
        }
        self[name] = node.stringValue
      } else if node._isNamespace {
        if node._isDefaultNamespace {
          self[.namespaceDeclaration(.default)] = node.stringValue
        } else if let name = node.name.flatMap(NoncolonizedName.init(_:)) {
          self[.namespaceDeclaration(.namespace(name))] = node.stringValue
        } else {
          throw NodeError.invalidAttributeName
        }
      } else {
        throw NodeError.unexpectedNode(node)
      }
    }
  }
  
  public init(attributesOf xmlElement: XMLElement) {
    var nodes: [XMLNode] = []
    if let attributes = xmlElement.attributes { nodes.append(contentsOf: attributes) }
    if let namespaces = xmlElement.namespaces { nodes.append(contentsOf: namespaces) }
    try! self.init(nodes)
  }
}

extension Comment {
  internal convenience init(_xmlNode xmlNode: XMLNode) throws {
    assert(xmlNode._isComment)
    try self.init(xmlNode._commentText)
  }
}

extension ProcessingInstruction {
  internal convenience init(_xmlNode xmlNode: XMLNode) throws {
    assert(xmlNode._isProcessingInstruction)
    
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if canImport(ObjectiveC) || compiler(>=5.1)
    guard let target = xmlNode.name.flatMap(NoncolonizedName.init(_:)) else {
      throw NodeError.invalidProcessingInstructionName
    }
    self.init(target: target, content: xmlNode.stringValue)
    #else
    class _Delegate: NSObject, XMLParserDelegate {
      var error: Error? = nil
      var pi: ProcessingInstruction? = nil
      public func parser(_ parser: XMLParser,
                         foundProcessingInstructionWithTarget target: String,
                         bytes: String?) {
        guard let targetName = NoncolonizedName(target) else {
          self.error = NodeError.invalidProcessingInstructionName
          parser.abortParsing()
          return
        }
        self.pi = ProcessingInstruction(target: targetName, content: bytes)
      }
    }
    let parser = XMLParser(bytes: xmlNode.xmlString.data(using: .utf8)!)
    let delegate = _Delegate()
    parser.delegate = delegate
    _ = parser.parse()
    if let error = parser.delegate.error { throw error }
    guard let pi = delegate.pi else { throw NodeError.unexpectedNode(xmlNode) }
    self.init(target: pi.target, content: pi.content)
    #endif
  }
}

extension Text {
  internal convenience init(_xmlNode xmlNode: XMLNode) throws {
    assert(xmlNode._isText)
    
    guard let text = xmlNode.stringValue else { throw NodeError.unexpectedNode(xmlNode) }
    self.init(text)
  }
}


private protocol _Node_XMLNode {}
extension Node: _Node_XMLNode {}
extension _Node_XMLNode {
  fileprivate init(_xmlNode xmlNode: XMLNode, xhtmlPrefix: QualifiedName.Prefix) throws {
    // Comment
    if xmlNode._isComment {
      guard let comment = try Comment(_xmlNode: xmlNode) as? Self else {
        throw NodeError.unexpectedNode(xmlNode)
      }
      self = comment
      return
    }
    
    // ProcessingInstruction
    if xmlNode._isProcessingInstruction {
      guard let pi = try ProcessingInstruction(_xmlNode: xmlNode) as? Self else {
        throw NodeError.unexpectedNode(xmlNode)
      }
      self = pi
      return
    }
    
    // Text
    if xmlNode._isText {
      guard let text = try Text(_xmlNode: xmlNode) as? Self else {
        throw NodeError.unexpectedNode(xmlNode)
      }
      self = text
      return
    }
    
    // Expects normal element
    guard case let xmlElement as XMLElement = xmlNode else { throw NodeError.unexpectedNode(xmlNode) }
    guard let name = xmlElement.name.flatMap(QualifiedName.init) else { throw NodeError.invalidName }
    let attributes = Attributes(attributesOf: xmlElement)
    let element = try Element(_name: name, attributes: attributes, xhtmlPrefix: xhtmlPrefix)
    if !(element is Self) {
      throw NodeError.unexpectedNode(xmlNode)
    }
    
    if let children = xmlElement.children {
      for child in children {
        element.append(try Node(child, xhtmlPrefix: xhtmlPrefix))
      }
    }
    self = element as! Self
  }
}

extension Node {
  /// Initialize with an instance of `XMLNode`.
  /// You can specify the prefix of XHTML by passing `xhtmlPrefix`.
  public convenience init(_ xmlNode: XMLNode, xhtmlPrefix: QualifiedName.Prefix = .none) throws {
    try self.init(_xmlNode: xmlNode, xhtmlPrefix: xhtmlPrefix)
    _trimTexts()
  }
}
