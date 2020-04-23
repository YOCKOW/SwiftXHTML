/* *************************************************************************************************
 HTMLElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents "<html>...</html>"
open class HTMLElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "html" }
  
  /// Always `false` because HTML element must have children.
  public override final var isEmpty: Bool { return false }
  
  open internal(set) weak var document: Document? = nil
  
  public var head: HeadElement? {
    for child in self.children {
      if case let headElement as HeadElement = child { return headElement }
    }
    return nil
  }
  
  public var body: BodyElement? {
    for child in self.children {
      if case let bodyElement as BodyElement = child { return bodyElement }
    }
    return nil
  }
  
  public required init(name: QualifiedName, attributes: Attributes = [:], children: [Node] = []) throws {
    var attrs = attributes
    if attrs._namespace(for:name) == nil {
      attrs[.namespaceDeclaration(name.prefix)] = String._xhtmlNamespace
    }
    try super.init(name: name, attributes: attributes, children: children)
  }
}
