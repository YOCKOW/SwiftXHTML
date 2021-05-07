/* *************************************************************************************************
 AddressElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<address\>\</address\>.
open class AddressElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName {
    return "address"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
}
