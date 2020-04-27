/* *************************************************************************************************
 SelectableElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
public protocol SelectableElement where Self: Element {
  var isSelected: Bool { get set }
}

extension SelectableElement {
  public var isSelected: Bool {
    get {
      return self.attributes["selected"] == "selected"
    }
    set {
      self.attributes["selected"] = newValue ? "selected" : nil
    }
  }
}
