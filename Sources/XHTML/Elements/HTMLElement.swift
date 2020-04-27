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
  
  /// Initialize with specified `name`, `attributes`, and `children`.
  /// Default XHTML namespace will be set when `attributes` does not contain the namespace.
  public required init(name: QualifiedName, attributes: Attributes = [:], children: [Node] = []) throws {
    var attributes = attributes
    if attributes._namespace(for: name) == nil {
      attributes[.namespaceDeclaration(name.prefix)] = String._xhtmlNamespace
    }
    try super.init(name: name, attributes: attributes, children: children)
  }
}
