/* *************************************************************************************************
 List.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<ol>\</ol>
open class OrderedListElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "ol"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

/// Represents \<ul>\</ul>
open class UnorderedListElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "ul"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

/// Represents \<li>\</li>
open class ListItemElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "li"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
