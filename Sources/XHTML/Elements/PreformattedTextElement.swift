/* *************************************************************************************************
 PreformattedTextElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import StringComposition

open class PreformattedTextElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "pre"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
  
  open override var prettyXHTMLLines: StringLines {
    return StringLines([StringLine(xhtmlString)!])
  }
  
  override func _trimTexts() {
    // Don't trim all texts
    if case let firstChild as Text = children.first, firstChild.text.first?.isNewline == true {
      firstChild.text = String(firstChild.text.dropFirst())
    }
    
    guard children.count > 1 else { return }
    if case let lastChild as Text = children.last, lastChild.text.last?.isNewline == true {
      lastChild.text = String(lastChild.text.dropLast())
    }
    
    removeEmptyTextNodes()
  }
}

