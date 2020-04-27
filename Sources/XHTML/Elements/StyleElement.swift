/* *************************************************************************************************
 StyleElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class StyleElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "style" }
  
  public override final var isEmpty: Bool { return false }
  
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
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none,
                          media: String? = nil, nonce: String? = nil, type: String = "text/css",
                          css: String) throws {
    try self.init(xhtmlPrefix: xhtmlPrefix)
    self.media = media
    self.nonce = nonce
    self.type = type
    self.children = [.cdata("\n" + css + "\n")]
  }
}
