/* *************************************************************************************************
 StyleElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class StyleElement: SpecifiedElement {
  open override class var localName: NoncolonizedName { return "style" }
  
  open override var isEmpty: Bool { return false }
  
  /// Media Query (Specifies what media/device the media resource is optimized for)
  open var media: String? {
    get {
      return self.attributes["media"]
    }
    set {
      self.attributes["media"] = newValue
    }
  }
  
  /// Number used ONCE.
  open var nonce: String? {
    get {
      return self.attributes["nonce"]
    }
    set {
      self.attributes["nonce"] = newValue
    }
  }
  
  /// Specifies the media type
  open var type: String {
    get {
      return self.attributes["type"] ?? "text/css"
    }
    set {
      self.attributes["type"] = newValue
    }
  }
}
