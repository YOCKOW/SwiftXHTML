/* *************************************************************************************************
 AsideElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 

open class AsideElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "aside"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}
