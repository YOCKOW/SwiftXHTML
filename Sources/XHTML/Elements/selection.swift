/* *************************************************************************************************
 selection.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class OptionElement:
  SpecifiedElement,
  DisableableElement,
  InitializableWithSimpleTextContent,
  SelectableElement
{
  public override class final var localName: NoncolonizedName {
    return "option"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
  
  public class func placeholder(xhtmlPrefix: QualifiedName.Prefix = .none, _ text: String) -> OptionElement {
    return try! OptionElement(xhtmlPrefix: xhtmlPrefix, value: "", text: text)
  }
  
  internal override func _setParent(_ newParent: Element?) throws {
    if let parent = newParent {
      guard parent is SelectionElement || parent is OptionGroupElement || parent is DataListElement else {
        throw ElementError.invalidParent(expected: ["select", "optgroup", "datalist"],
                                         actual: parent.name.localName)
      }
    }
    try super._setParent(newParent)
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none, value: String, text: String, isSelected: Bool = false) throws {
    try self.init(xhtmlPrefix: xhtmlPrefix)
    self.attributes["value"] = value
    self.children = [.text(text)]
    self.isSelected = isSelected
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none, value: String, label: String, isSelected: Bool = false) throws {
    try self.init(xhtmlPrefix: xhtmlPrefix)
    self.attributes["value"] = value
    self.attributes["label"] = label
    self.isSelected = isSelected
  }
}

open class OptionGroupElement: SpecifiedElement, DisableableElement {
  public override class final var localName: NoncolonizedName {
    return "optgroup"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
  
  internal override func _setParent(_ newParent: Element?) throws {
    if let parent = newParent {
      guard parent is SelectionElement else {
        throw ElementError.invalidParent(expected: ["select"], actual: parent.name.localName)
      }
    }
    try super._setParent(newParent)
  }
  
  public var label: String? {
    get {
      return self.attributes["label"]
    }
    set {
      self.attributes["label"] = newValue ?? ""
    }
  }
  
  public convenience init<S>(xhtmlPrefix: QualifiedName.Prefix = .none, label: String, options: S) throws where S: Sequence, S.Element: OptionElement{
    try self.init(xhtmlPrefix: xhtmlPrefix, children: Array(options))
    self.label = label
  }
}

open class SelectionElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName {
    return "select"
  }
  
  public override final var isEmpty: Bool {
    return false
  }
  
  public convenience init<S>(
    xhtmlPrefix: QualifiedName.Prefix = .none,
    attributes: Attributes = [:],
    options: S
  ) throws where S: Sequence, S.Element: OptionElement {
    try self.init(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: Array(options))
  }
  
  public convenience init<S>(
    xhtmlPrefix: QualifiedName.Prefix = .none,
    attributes: Attributes = [:],
    optionGroups: S
  ) throws where S: Sequence, S.Element: OptionGroupElement {
    try self.init(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: Array(optionGroups))
  }
}
