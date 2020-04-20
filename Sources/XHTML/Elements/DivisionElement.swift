/* *************************************************************************************************
 DivisionElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class DivisionElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "div"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
