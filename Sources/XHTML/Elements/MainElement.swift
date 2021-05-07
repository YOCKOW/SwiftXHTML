/* *************************************************************************************************
 MainElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<main>\</main>
open class MainElement: SpecifiedElement, BlockLevelElement {
  public final override class var localName: NoncolonizedName {
    return "main"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
