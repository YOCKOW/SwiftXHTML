/* *************************************************************************************************
 List.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class OrderedListElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "ol"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

open class UnorderedListElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "ul"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

open class ListItemElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "li"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
