/* *************************************************************************************************
 FormElement.swift
   © 2019,2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import NetworkGear
import yExtensions

/// Represents \<form>\</form>
open class FormElement: SpecifiedElement, BlockLevelElement {
  public override class final var localName: NoncolonizedName { return "form" }
  
  /// The location where to submit the form.
  open var action: String? {
    get {
      return self.attributes["action"]
    }
    set {
      self.attributes["action"] = newValue
    }
  }
  
  open var autocomplete: Bool {
    get {
      return self.attributes["autocomplete"] == "off" ? false : true
    }
    set {
      self.attributes["autocomplete"] = newValue ? "on" : "off"
    }
  }
  
  /// The value of "enctype"
  open var encodingType: MIMEType? {
    get {
      return self.attributes["enctype"].flatMap(MIMEType.init)
    }
    set {
      self.attributes["enctype"] = newValue?.description
    }
  }
  
  /// The HTTP method used when submitting the form
  open var method: HTTPMethod? {
    get {
      return self.attributes["method"].flatMap(HTTPMethod.init(rawValue:))
    }
    set {
      self.attributes["method"] = newValue?.rawValue
    }
  }
  
  /// The value of "accept-charset"
  open var stringEncoding: String.Encoding? {
    get {
      return self.attributes["accept-charset"].flatMap(String.Encoding.init(ianaCharacterSetName:))
    }
    set {
      self.attributes["accept-charset"] = newValue?.ianaCharacterSetName
    }
  }
}
