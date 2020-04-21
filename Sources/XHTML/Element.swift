/* *************************************************************************************************
 Element.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import StringComposition
import yExtensions
 
open class Element: Node {
  open var name: QualifiedName
  
  private var _attributes: Attributes = [:]
  public var attributes: Attributes {
    get {
      return self._attributes
    }
    set {
      self._attributes.element = nil
      self._attributes = newValue
      self._attributes.element = self
    }
  }
  
  private var _children: [Node] = []
  public var children: [Node] {
    get {
      return self._children
    }
    set {
      self._children = newValue
      for child in self._children {
        child.parent = self
      }
    }
  }
  
  /// Returns the Boolean value that indicates whether the receiver is an empty-element or not.
  open var isEmpty: Bool {
    return self._children.isEmpty
  }
  
  public override func isEqual(to other: Node) -> Bool {
    guard case let anotherElement as Element = other else { return false }
    return (
      self.name == anotherElement.name &&
        self.attributes == anotherElement.attributes &&
        self.children == anotherElement.children
    )
  }
  
  public init(name: QualifiedName) {
    self.name = name
  }
  
  /// Initialize with `name`, and then add `attributes`.
  public required init(name: QualifiedName, attributes: Attributes) {
    self.name = name
    super.init()
    
    self.attributes = attributes
  }
  
  /// Initialize with `name`, and then add `attributes` and `children`.
  public required init(name: QualifiedName, attributes: Attributes, children: [Node]) {
    self.name = name
    super.init()
    
    self.attributes = attributes
    self.children = children
  }
  
  open override var xhtmlString: String {
    let tagName = self.name.description
    
    var result = "<\(tagName)"
    
    if !self.attributes.isEmpty {
      result += " \(self.attributes.xhtmlString)"
    }
    
    if self.isEmpty {
      return result + " />"
    }
    
    result += ">"
    result += self.children.map({ $0.xhtmlString }).joined()
    result += "</\(tagName)>"
    
    return result
    
  }
  
  open override var prettyXHTMLLines: StringLines {
    let tagName = self.name.description
    
    var result = StringLines()
    
    do { // Start Tag
      var attributesLines = self.attributes.prettyXHTMLLines
      switch attributesLines.count {
      case 0:
        result.append("<\(tagName)")
      case 1:
        result.append("<\(tagName) \(attributesLines[0].payload)")
      default:
        attributesLines.shiftRight()
        result.append("<\(tagName)")
        result.append(contentsOf: attributesLines)
      }
      result[result.endIndex - 1].payload += self.isEmpty ? " />" : ">"
    }
    
    let endTag = "</\(tagName)>"
    appendChildrenAndEndTag: do {
      if self.isEmpty { break appendChildrenAndEndTag }
      
      var childrenLines = self.children.reduce(into: StringLines()) {
        $0.append(contentsOf: $1.prettyXHTMLLines)
      }
      if result.count == 1 && childrenLines.count == 1 {
        let startTagWidth = result[0].payloadProperties.estimatedWidth
        let childWidth = childrenLines[0].payloadProperties.estimatedWidth
        let endTagWidth = endTag.estimatedWidth
        if startTagWidth + childWidth + endTagWidth < 100 {
          result[0].payload += childrenLines[0].payload + endTag
          break appendChildrenAndEndTag
        }
      }
      childrenLines.shiftRight()
      result.append(contentsOf: childrenLines)
      result.append(String.Line(endTag)!)
    }
    
    return result
  }
  
  public func append(_ child:Node) {
    child.parent = self
    self._children.append(child)
  }
  
  public func firstIndex(of child: Node) -> Int? {
    return self._children.firstIndex(of: child)
  }
  
  public func insert(_ child:Node, at index:Int) {
    child.parent = self
    self._children.insert(child, at:index)
  }
  
  public func removeChild(at index:Int) {
    let child = self._children.remove(at:index)
    child.parent = nil
  }
  
  public func remove(_ child: Node) {
    if let index = self.firstIndex(of: child) {
      self.removeChild(at: index)
    }
  }
}

extension Element {
  /// Returns URI that specifies namespace for `prefix`.
  public func namespace(for prefix: QualifiedName.Prefix) -> String? {
    // Don't call `Attributes.namespace(for:)`, or induce infinite loop.
    if let namespace = self._attributes._namespace(for:prefix) {
      return namespace
    }
    guard let parent = self.parent else { return nil }
    return parent.namespace(for:prefix)
  }
  
  /// Returns URI that specifies namespace for prefix of `qName`.
  public func namespace(for qName:QualifiedName) -> String? {
    return self.namespace(for:qName.prefix)
  }
  
  /// Returns prefix for namespace specified by `uri`.
  public func prefix(for uri: String) -> QualifiedName.Prefix? {
    if let prefix = self._attributes._prefix(for:uri) {
      return prefix
    }
    guard let parent = self.parent else { return nil }
    return parent.prefix(for:uri)
  }
}

extension Element {
  /// Returns an instance of `Element` representing the element whose id property matches
  /// the specified `identifier`.
  public func element(for identifier:String) -> Element? {
    if self.attributes[localName:"id", uri:._xhtmlNamespace] == identifier {
      return self
    }
    
    for child in self.children {
      if case let childElement as Element = child,
        let theElement = childElement.element(for:identifier)
      {
        return theElement
      }
    }
    
    return nil
  }
}
