/* *************************************************************************************************
 ParagraphElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class ParagraphElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "p"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}
