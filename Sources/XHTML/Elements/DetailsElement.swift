/* *************************************************************************************************
 DetailsElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class DetailsElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "details"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
