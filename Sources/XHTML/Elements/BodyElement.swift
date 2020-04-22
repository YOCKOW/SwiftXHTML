/* *************************************************************************************************
 BodyElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Represents "\<body\>...\</body\>"
open class BodyElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "body" }
  
  /// Always `false` because HTML element must have children.
  public override final var isEmpty: Bool { return false }
}

