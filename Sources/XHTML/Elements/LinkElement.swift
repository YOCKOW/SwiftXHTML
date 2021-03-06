/* *************************************************************************************************
 LinkElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class LinkElement: PerpetuallyEmptyElement {
  public override class final var localName: NoncolonizedName { return "link" }
  
  open var relationship: Relationship? {
    get {
      return self.attributes["rel"].flatMap(Relationship.init(rawValue:))
    }
    set {
      self.attributes["rel"] = newValue?.rawValue
    }
  }
  
  open var hypertextReference: String? {
    get {
      return self.attributes["href"]
    }
    set {
      self.attributes["href"] = newValue
    }
  }
  
  public required init(name: QualifiedName, attributes: Attributes = [:], children: [Node] = []) throws {
    try super.init(name: name, attributes: attributes, children: children)
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none,
                          relationship: Relationship,
                          hypertextReference: String,
                          attributes: Attributes = [:]) throws {
    try self.init(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
    self.relationship = relationship
    self.hypertextReference = hypertextReference
  }
}
