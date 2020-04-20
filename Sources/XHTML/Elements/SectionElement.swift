/* *************************************************************************************************
 SectionElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class SectionElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "section"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}
