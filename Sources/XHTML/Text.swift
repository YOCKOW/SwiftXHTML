/* *************************************************************************************************
 Text.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

/// Represents text.
open class Text: Node {
  open var text: String
  public init(_ text:String) {
    self.text = text
  }
  
  public override func isEqual(to other: Node) -> Bool {
    guard case let otherText as Text = other else { return false }
    return self.text == otherText.text
  }
  
  open override var xhtmlString: String {
    return self.text._addingAmpersandEncoding()
  }
  
  open override var prettyXHTMLLines: StringLines {
    let rawLines = self.text.split(omittingEmptySubsequences: false, whereSeparator: { $0.isNewline })
    let escaped = rawLines.map({ $0._addingAmpersandEncoding() })
    return StringLines(escaped.map({ String.Line($0, indentLevel: 0)! }))
  }
}
