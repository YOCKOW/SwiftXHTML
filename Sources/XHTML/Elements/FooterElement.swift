/* *************************************************************************************************
 FooterElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class FooterElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "footer"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}


