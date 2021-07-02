/* *************************************************************************************************
 TextNodeConvertible.swift
   © 2019-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

public protocol TextNodeConvertible {
  var textNode: Text { get }
}

/// Represents text.
open class Text: Node, TextNodeConvertible {
  open var text: String
  
  public var textNode: Text {
    return self
  }
  
  public init(_ text:String) {
    self.text = text
  }
  
  public override func isEqual(to other: Node) -> Bool {
    guard case let otherText as Text = other else { return false }
    return self.text == otherText.text
  }

  private var _shouldUseMinimumAmpersandEncoding: Bool {
    var node: Node = self
    while let parent = node.parent {
      if parent._descendantTextNodesShouldUseMinimumAmpersandEncoding {
        return true
      }
      node = parent
    }
    return false
  }
  
  open override var xhtmlString: String {
    if _shouldUseMinimumAmpersandEncoding {
      return text._addingMinimumAmpersandEncoding()
    } else {
      return text._addingUntrimmedAmpersandEncoding()
    }
  }
  
  open override var prettyXHTMLLines: StringLines {
    let escape: (Substring) -> String = _shouldUseMinimumAmpersandEncoding ? {
      return $0._addingMinimumAmpersandEncoding()
    } : {
      return $0._addingUntrimmedAmpersandEncoding()
    }
    let rawLines = self.text.split(omittingEmptySubsequences: false, whereSeparator: { $0.isNewline })
    let escapedLines = rawLines.map(escape)
    return StringLines(escapedLines.map({ String.Line($0, indentLevel: 0)! }))
  }
  
  override func _trimTexts() {
    self.text = self.text.trimmingUnicodeScalars(in: .xmlWhitespaces)
  }
}

open class CDATASection: Node, TextNodeConvertible {
  private static func _validate(text: String) -> Bool {
    return !text.contains("]]>")
  }
  
  private var _text: String
  public var text: String {
    get {
      return self._text
    }
    set {
      guard Self._validate(text: newValue) else { fatalError("Invalid String for CDATASection.") }
      self._text = newValue
    }
  }
  
  public var textNode: Text {
    return Text(self._text)
  }
  
  open override var xhtmlString: String {
    return "<![CDATA[\(self._text)]]>"
  }
  
  open override var prettyXHTMLLines: StringLines {
    return StringLines(self.xhtmlString, detectIndent: false)
  }
  
  public init(_ text: String) throws {
    guard Self._validate(text: text) else { throw NodeError.invalidString }
    self._text = text
  }
  
  public convenience init(_ textNode: Text) throws {
    try self.init(textNode.text)
  }
  
  override func _trimTexts() {
    self.text = self.text.trimmingUnicodeScalars(in: .xmlWhitespaces)
  }
}
