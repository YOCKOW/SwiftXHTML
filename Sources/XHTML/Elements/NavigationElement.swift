/* *************************************************************************************************
 NavigationElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class NavigationElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "nav"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}

