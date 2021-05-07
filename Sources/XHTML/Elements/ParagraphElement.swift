/* *************************************************************************************************
 ParagraphElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<p>\</p>
open class ParagraphElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "p"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
