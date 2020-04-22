/* *************************************************************************************************
 ButtonElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class ButtonElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "button"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
