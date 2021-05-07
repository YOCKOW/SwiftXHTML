/* *************************************************************************************************
 DetailsElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<details\>\</details\>.
open class DetailsElement: SpecifiedElement, BlockLevelElement {
  public final override class var localName: NoncolonizedName {
    return "details"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
