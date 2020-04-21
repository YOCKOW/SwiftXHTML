/* *************************************************************************************************
 SelectionElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

open class SelectionElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "select"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
