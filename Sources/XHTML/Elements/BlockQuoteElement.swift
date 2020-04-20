/* *************************************************************************************************
 BlockQuoteElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class BlockQuoteElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "blockquote"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}

