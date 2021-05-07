/* *************************************************************************************************
 FooterElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<footer>\</footer>
open class FooterElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "footer"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}


