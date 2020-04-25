/* *************************************************************************************************
 Text.swift
   © 2019-2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

/// Represents text.
open class Text: Node {
  open var text: String
  
  public init(_ text:String) throws {
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

open class CDATASection: Text {
  private static func _validate(text: String) -> Bool {
    return !text.contains("]]>")
  }
  
  private var _text: String
  public override var text: String {
    get {
      return self._text
    }
    set {
      guard Self._validate(text: newValue) else { fatalError("Invalid String for CDATASection.") }
      self._text = newValue
    }
  }
  
  open override var xhtmlString: String {
    return "<![CDATA[\(self._text)]]>"
  }
  
  open override var prettyXHTMLLines: StringLines {
    return StringLines(self.xhtmlString, detectIndent: false)
  }
  
  public override init(_ text: String) throws {
    guard Self._validate(text: text) else { throw NodeError.invalidString }
    self._text = text
    try super.init(text)
  }
  
  public convenience init(_ textNode: Text) throws {
    try self.init(textNode.text)
  }
}
