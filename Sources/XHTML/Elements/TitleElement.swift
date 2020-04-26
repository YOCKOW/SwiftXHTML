/* *************************************************************************************************
 TitleElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents "\<title\>...\</title\>"
open class TitleElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public override class final var localName: NoncolonizedName { return "title" }
  
  public override final var isEmpty: Bool { return false }
  
  /// The title of the XHTML document; i.e. the text content of \<title\>
  public var title: String {
    get {
      var result = ""
      for child in self.children {
        guard case let textNode as Text = child else { continue }
        result += textNode.text
      }
      return result
    }
    set {
      self.children = [Text(newValue)]
    }
  }
}
