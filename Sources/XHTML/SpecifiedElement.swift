/* *************************************************************************************************
 SpecifiedElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class SpecifiedElement: Element {
  /// The local name that the element must have.
  /// This class property must be overridden in child classes.
  open class var localName: NoncolonizedName { fatalError("Must be overriden.") }
  
  private var _name: QualifiedName!
  open override var name: QualifiedName {
    get {
      return self._name
    }
    set {
      guard newValue.localName == type(of:self).localName else {
        fatalError("Local name must be \"\(type(of:self).localName)\".")
      }
      self._name = newValue
    }
  }
  
  public override init(name:QualifiedName) {
    super.init(name:name)
    self.name = name
  }
  
  public required convenience init(name: QualifiedName, attributes: Attributes) {
    self.init(name: name)
    self.attributes = attributes
  }
  
  public convenience init(name: QualifiedName, attributes: Attributes, children: [Node]) {
    self.init(name: name, attributes: attributes)
    self.children = children
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none,
                          attributes: Attributes = [:],
                          children: [Node] = []) {
    self.init(name: QualifiedName(prefix: xhtmlPrefix, localName: type(of: self).localName),
              attributes: attributes,
              children: children)
  }
}
