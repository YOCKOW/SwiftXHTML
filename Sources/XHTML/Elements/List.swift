/* *************************************************************************************************
 List.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class OrderedListElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "ol"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}

open class UnorderedListElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "ul"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}

open class ListItemElement: SpecifiedElement {
  open override class var localName: NoncolonizedName {
    return "li"
  }
  
  open override var isEmpty: Bool {
    return false
  }
}
