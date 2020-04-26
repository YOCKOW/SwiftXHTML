/* *************************************************************************************************
 BaseElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

/// Represents \<base\> element.
open class BaseElement: PerpetuallyEmptyElement, TargetHoldableElement {
  public override class final var localName: NoncolonizedName {
    return "base"
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
                          hypertextReference: String,
                          target: TargetAttributeValue? = nil) throws {
    try self.init(name: QualifiedName(prefix: xhtmlPrefix, localName: Self.localName))
    self.hypertextReference = hypertextReference
    self.target = target
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none,
                          target: TargetAttributeValue) throws {
    try self.init(name: QualifiedName(prefix: xhtmlPrefix, localName: Self.localName))
    self.target = target
  }
}

