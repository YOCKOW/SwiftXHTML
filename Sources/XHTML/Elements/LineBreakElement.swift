/* *************************************************************************************************
 LineBreakElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

/// Represents \<br />
open class LineBreakElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "br" }
  open override var isEmpty: Bool { return true }
  
  open override var prettyXHTMLLines: StringLines {
    return StringLines("<br />\n", detectIndent: false)
  }
}
