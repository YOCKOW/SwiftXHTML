/* *************************************************************************************************
 ArticleElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Represents \<article\>\</article\>.
open class ArticleElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "article"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
