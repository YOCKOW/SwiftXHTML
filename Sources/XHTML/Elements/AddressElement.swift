/* *************************************************************************************************
 AddressElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class AddressElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "address"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}
