/* *************************************************************************************************
 NavigationElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<nav>\</nav>
open class NavigationElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "nav"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}

