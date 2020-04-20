/* *************************************************************************************************
 PreformattedTextElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class PreformattedTextElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "pre"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}

