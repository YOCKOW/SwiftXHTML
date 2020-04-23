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
      try! self._setName(newValue)
    }
  }
  
  private func _setName(_ newName: QualifiedName) throws {
    let expectedLocalName = type(of: self).localName
    if newName.localName != expectedLocalName {
      throw ElementError.invalidLocalName(expected: expectedLocalName, actual: newName.localName)
    }
    self._name = newName
  }
  
  public required init(name: QualifiedName, attributes: Attributes = [:], children: [Node] = []) throws {
    try super.init(name: name, attributes: attributes, children: children)
    try self._setName(name)
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none,
                          attributes: Attributes = [:],
                          children: [Node] = []) throws {
    try self.init(name: QualifiedName(prefix: xhtmlPrefix, localName: type(of: self).localName),
                  attributes: attributes,
                  children: children)
  }
}
