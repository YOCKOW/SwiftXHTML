/* *************************************************************************************************
 BlockQuoteElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<blockquote\>\</blockquote\>.
open class BlockQuoteElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "blockquote"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

