/* *************************************************************************************************
 AsideElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

open class AsideElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "aside"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
