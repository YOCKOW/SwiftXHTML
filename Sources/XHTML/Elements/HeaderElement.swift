/* *************************************************************************************************
 HeaderElement.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<header>\</header>
open class HeaderElement: SpecifiedElement, BlockLevelElement {
   public override class final var localName: NoncolonizedName {
     return "header"
   }
   
   public override final var isEmpty: Bool {
     return false
   }
 }

