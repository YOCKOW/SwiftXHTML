/* *************************************************************************************************
 Attributes.swift
   © 2018-2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents attributes of XHTML Element.
public struct Attributes: Equatable {
  private var _attributes:[AttributeName:String]
  private var _attributesForLocalName:[NoncolonizedName:[AttributeName:String]]
  
  /// Owner of the attributes.
  public internal(set) weak var element: Element? = nil
  
  public init() {
    self._attributes = [:]
    self._attributesForLocalName = [:]
  }
  
  public static func ==(lhs:Attributes, rhs:Attributes) -> Bool {
    return lhs._attributes == rhs._attributes
  }
  
  public var isEmpty: Bool {
    return self._attributes.isEmpty
  }
}

extension Attributes {
  /// Returns the attribute value with the specified `name`.
  public subscript(_ name:AttributeName) -> String? {
    get {
      return self._attributes[name]
    }
    set {
      self._attributes[name] = newValue
      switch name {
      case .namespaceDeclaration(let prefix):
        guard case .namespace(let ncName) = prefix else { break }
        if self._attributesForLocalName[ncName] == nil {
          self._attributesForLocalName[ncName] = [:]
        }
        self._attributesForLocalName[ncName]![name] = newValue
      case .attributeName(let qName):
        if self._attributesForLocalName[qName.localName] == nil {
          self._attributesForLocalName[qName.localName] = [:]
        }
        self._attributesForLocalName[qName.localName]![name] = newValue
      }
    }
  }
  
  internal func _namespace(for prefix: QualifiedName.Prefix) -> String? {
    return self[.namespaceDeclaration(prefix)]
  }
  
  internal func _namespace(for qName:QualifiedName) -> String? {
    return self._namespace(for:qName.prefix)
  }
  
  /// Returns URI that specifies namespace for `prefix`.
  public func namespace(for prefix: QualifiedName.Prefix) -> String? {
    if let element = self.element {
      return element.namespace(for: prefix == .none ? element.name.prefix : prefix)
    }
    return self._namespace(for:prefix)
  }
  
  /// Returns URI that specifies namespace for prefix of `qName`.
  public func namespace(for qName:QualifiedName) -> String? {
    return self.namespace(for:qName.prefix)
  }
  
  internal func _prefix(for uri:String) -> QualifiedName.Prefix? {
    for (name, value) in self._attributes {
      if value != uri { continue }
      switch name {
      case .namespaceDeclaration(let prefix):
        return prefix
      default:
        break
      }
    }
    return nil
  }
  
  /// Returns prefix for namespace specified by `uri`.
  public func prefix(for uri: String) -> QualifiedName.Prefix? {
    if let element = self.element {
      let prefix = element.prefix(for:uri)
      if prefix == element.name.prefix { return .default }
      return prefix
    }
    return self._prefix(for:uri)
  }
  
  /// The attribute value that is identified by a local name and URI.
  public subscript(localName localName:NoncolonizedName, uri uri:String?) -> String? {
    get {
      if let namespace = uri {
        guard let list = self._attributesForLocalName[localName] else { return nil }
        for (name, value) in list {
          guard case .attributeName(let qName) = name else { continue }
          if self.namespace(for:qName) == namespace { return value }
        }
        return nil
      } else {
        // uri == nil
        if let value = self[.attributeName(QualifiedName(localName:localName))] {
          return value
        } else if let prefix = self.element?.name.prefix {
          return self[.attributeName(QualifiedName(prefix:prefix, localName:localName))]
        }
        return nil
      }
    }
    set {
      if let namespace = uri {
        guard let prefix = self.prefix(for:namespace) else {
          fatalError("No namespace for \(namespace)")
        }
        if case .none = prefix {
          self[.attributeName(QualifiedName(localName:localName))] = newValue
        } else {
          self[.attributeName(QualifiedName(prefix:prefix, localName:localName))] = newValue
        }
      } else {
        self[.attributeName(QualifiedName(localName:localName))] = newValue
      }
    }
  }
}

extension Attributes {
  internal init(_ dictionary:[String:String]) {
    self.init()
    for (key, value) in dictionary {
      guard let name = AttributeName(key) else { continue }
      self[name] = value
    }
  }
}

extension Attributes: ExpressibleByDictionaryLiteral {
  public typealias Key = AttributeName
  public typealias Value = String
  public init(dictionaryLiteral elements: (AttributeName, String)...) {
    self.init()
    for element in elements {
      self[element.0] = element.1
    }
  }
}

extension Attributes: Sequence {
  public func makeIterator() -> DictionaryIterator<AttributeName, String> {
    return self._attributes.makeIterator()
  }
}
