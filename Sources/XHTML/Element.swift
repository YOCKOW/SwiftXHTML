/* *************************************************************************************************
 Element.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
 
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
  
  public init(name:QualifiedName) {
    self.name = name
  }
  
  /// Initialize with `name`, and then add `attributes`.
  public required convenience init(name:QualifiedName, attributes:Attributes) {
    self.init(name:name)
    self.attributes = attributes
  }
  
  /// Initialize with `name`, and then add `attributes` and `children`.
  public convenience init(name:QualifiedName,
                          attributes:Attributes,
                          children:[Node])
  {
    self.init(name:name, attributes:attributes)
    self.children = children
  }
  
  internal var _startTag: String {
    var result = "<\(self.name.description)"
    if !self.attributes.isEmpty {
      result += " " +
        self.attributes.map { (name:AttributeName, value:String) -> String in
          return "\(name.description)=\"\(value._addingAmpersandEncoding())\""
        }.joined(separator:" ")
    }
    if self.isEmpty {
      result += " />"
    } else {
      result += ">"
    }
    return result
  }
  
  internal var _contentXHTMLString: String {
    return self.children.map { $0.xhtmlString }.joined()
  }
  
  internal var _endTag: String {
    return "</\(self.name.description)>"
  }
  
  open override var xhtmlString: String {
    var result = self._startTag
    if !self.isEmpty { result += self._contentXHTMLString + self._endTag }
    return result
  }
  
  internal override var _prettyXHTMLStringLines: [String] {
    if self.isEmpty {
      return [self._startTag]
    }
    
    let childrenLines: [[String]] = self.children.map{ $0._prettyXHTMLStringLines }
    let numberOfChildren = self.children.count
    let numberOfLines = childrenLines.reduce(0){ $0 + $1.count }
    
    if numberOfLines == 0 || (numberOfLines == 1 && childrenLines.last?.last?._endsWithNewline != true) {
      return [self.xhtmlString]
    }
    
    var result: [String] = [self._startTag + "\n"]
    for ii in 0..<numberOfChildren {
      let lines = childrenLines[ii]
      let nn = lines.count
      for jj in 0..<nn {
        let line = lines[jj]
        if jj < nn - 1 || line._endsWithNewline {
          // not the last line or ends with newline.
          result.append(_indent + line)
        } else {
          result.append(_indent + line + "\n")
        }
      }
    }
    result.append(self._endTag)
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
