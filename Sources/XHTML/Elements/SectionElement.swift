/* *************************************************************************************************
 SectionElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<section>\</section>
open class SectionElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "section"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
