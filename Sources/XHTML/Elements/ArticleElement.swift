/* *************************************************************************************************
 ArticleElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

open class ArticleElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "article"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}
