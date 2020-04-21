/* *************************************************************************************************
 LabelElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class LabelElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "label"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

