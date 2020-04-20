/* *************************************************************************************************
 HorizontalRuleElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class HorizontalRuleElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "hr" }
  open override var isEmpty: Bool { return true }
}
