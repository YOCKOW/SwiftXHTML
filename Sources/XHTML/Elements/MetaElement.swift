/* *************************************************************************************************
 MetaElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

open class MetaElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "meta" }
  
  /// Always `true`.
  public override final var isEmpty: Bool { return true }
  
  internal override func _setParent(_ newParent: Element?) throws {
    if let newParent = newParent {
      guard newParent is HeadElement else { throw ElementError.invalidParent(expected: "head", actual: newParent.name.localName) }
      try super._setParent(newParent)
    } else {
      try super._setParent(nil)
    }
  }
}

extension HeadElement {
  private func _metaElement(for name: String) -> MetaElement? {
    for child in self.children {
      guard case let meta as MetaElement = child else { continue }
      if meta.attributes["name"] == name {
        return meta
      }
    }
    return nil
  }
  
  private func _metaContent(for name: String) -> String? {
    return self._metaElement(for: name)?.attributes["content"]
  }
  
  private func _setMetaContent(_ content: String?, for name: String) {
    switch (content, self._metaElement(for: name)) {
    case (nil, nil):
      break
    case (nil, let meta?):
      self.remove(meta)
    case (let content?, nil):
      let meta = try! MetaElement(name: QualifiedName(prefix: self.name.prefix,
                                                      localName: "meta"),
                                  attributes: ["name": name, "content": content])
      self.append(meta)
    case (let content?, let meta?):
      meta.attributes["content"] = content
    }
  }
  
  public var applicationName: String? {
    get {
      return self._metaContent(for: "application-name")
    }
    set {
      self._setMetaContent(newValue, for: "application-name")
    }
  }
  
  public var author: String? {
    get {
      return self._metaContent(for: "author")
    }
    set {
      self._setMetaContent(newValue, for: "author")
    }
  }
  
  public var description: String? {
    get {
      return self._metaContent(for: "description")
    }
    set {
      self._setMetaContent(newValue, for: "description")
    }
  }
  
  public var generator: String? {
    get {
      return self._metaContent(for: "generator")
    }
    set {
      self._setMetaContent(newValue, for: "generator")
    }
  }
  
  public var keywords: [String]? {
    get {
      guard let keywords_string = self._metaContent(for: "keywords") else { return nil }
      return keywords_string.components(separatedBy: ",").map{
        $0.trimmingUnicodeScalars(in: .whitespacesAndNewlines)
      }
    }
    set {
      let keywords_string: String? = newValue?.joined(separator: ",")
      self._setMetaContent(keywords_string, for: "keywords")
    }
  }
  
  public var viewport: String? {
    get {
      return self._metaContent(for: "viewport")
    }
    set {
      self._setMetaContent(newValue, for: "viewport")
    }
  }
}
