/* *************************************************************************************************
 DivisionElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class DivisionElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "div"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}
