/* *************************************************************************************************
 DialogElement.swift
   © 2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<dialog\>\</dialog\>.
open class DialogElement: SpecifiedElement, BlockLevelElement {
  public final override class var localName: NoncolonizedName {
    return "dialog"
  }

  public final override var isEmpty: Bool {
    return false
  }
}
