/* *************************************************************************************************
 SectionElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class SectionElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "section"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
