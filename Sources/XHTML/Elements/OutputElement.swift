/* *************************************************************************************************
 OutputElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class OutputElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "output"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}



