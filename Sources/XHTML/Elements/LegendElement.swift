/* *************************************************************************************************
 LegendElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class LegendElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public override class final var localName: NoncolonizedName {
    return "legend"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
