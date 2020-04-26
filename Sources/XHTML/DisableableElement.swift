/* *************************************************************************************************
 DisableableElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
public protocol DisableableElement where Self: Element {
  var isDisabled: Bool { get set }
}

extension DisableableElement {
  public var isDisabled: Bool {
    get {
      return self.attributes["disabled"] == "disabled"
    }
    set {
      self.attributes["disabled"] = newValue ? "disabled" : nil
    }
  }
}
