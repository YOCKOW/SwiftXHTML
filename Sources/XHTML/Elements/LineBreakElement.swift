/* *************************************************************************************************
 LineBreakElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

/// Represents \<br />
open class LineBreakElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "br" }
  public override final var isEmpty: Bool { return true }
  
  open override var prettyXHTMLLines: StringLines {
    return StringLines("<br />\n", detectIndent: false)
  }
}
