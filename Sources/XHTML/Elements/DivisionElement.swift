/* *************************************************************************************************
 DivisionElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<div\>\</div\>.
open class DivisionElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "div"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
