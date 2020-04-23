/* *************************************************************************************************
 Break.swift
   © 2019-2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

/// Represents \<br />
open class LineBreakElement: PerpetuallyEmptyElement {
  public override class final var localName: NoncolonizedName { return "br" }
  
  open override var prettyXHTMLLines: StringLines {
    return StringLines("<br />\n", detectIndent: false)
  }
}

open class WordBreakElement: PerpetuallyEmptyElement {
  public final override class var localName: NoncolonizedName {
    return "wbr"
  }
}
