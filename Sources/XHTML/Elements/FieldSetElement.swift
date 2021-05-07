/* *************************************************************************************************
 FieldSetElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<fieldset\>\</fieldset\>.
open class FieldSetElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "fieldset"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

