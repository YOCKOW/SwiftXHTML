/* *************************************************************************************************
 AsideElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Represents \<aside\>\</aside\>.
open class AsideElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "aside"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
