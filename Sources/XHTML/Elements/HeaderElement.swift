/* *************************************************************************************************
 HeaderElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class HeaderElement: SpecifiedElement {
   open override class var localName: NoncolonizedName {
     return "header"
   }
   
   open override var isEmpty: Bool {
     return false
   }
 }

