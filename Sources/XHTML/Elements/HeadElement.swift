/* *************************************************************************************************
 HeadElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents "\<head\>...\</head\>"
open class HeadElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "head" }
  
  /// Always `false` because \<head> element must have children.
  public override final var isEmpty: Bool { return false }
  
  internal override func _setParent(_ newParent: Element?) throws {
    if let newParent = newParent {
      guard newParent is HTMLElement else { throw ElementError.invalidParent(expected: ["html"], actual: newParent.name.localName) }
      try super._setParent(newParent)
    } else {
      try super._setParent(nil)
    }
  }
  
  public var title: TitleElement? {
    for child in self.children {
      if case let titleElement as TitleElement = child { return titleElement }
    }
    return nil
  }
}
