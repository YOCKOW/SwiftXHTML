/* *************************************************************************************************
 Names.swift
   © 2018,2023 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import yExtensions

private func _validateNCName(_ string:String) -> Bool {
  guard let firstScalar = string.unicodeScalars.first, firstScalar.isXMLNameStart else { return false }
  guard string.unicodeScalars.allSatisfy(\.isAllowedInXMLNoncolonizedName) else { return false }
  return true
}

/// Represents [NCName](https://www.w3.org/TR/REC-xml-names/#NT-NCName).
public struct NoncolonizedName: CustomStringConvertible,
                                RawRepresentable,
                                ExpressibleByStringLiteral,
                                Hashable,
                                Comparable
{
  public typealias RawValue = String
  public typealias StringLiteralType = String
  
  private let _string:String
  public var description: String { return self._string }
  public var rawValue: String { return self._string }
  
  public static func <(lhs: NoncolonizedName, rhs: NoncolonizedName) -> Bool {
    return lhs._string < rhs._string
  }
  
  private init(uncheckedString:String) {
    self._string = uncheckedString
  }
  
  public init?(_ string:String) {
    guard _validateNCName(string) else { return nil }
    self.init(uncheckedString:string)
  }
  public init?(rawValue:String) { self.init(rawValue) }
  
  public init(stringLiteral value:String) {
    guard _validateNCName(value) else { fatalError("Invalid String as NCName: \(value)") }
    self.init(uncheckedString:value)
  }
}


/// Represents [QName](https://www.w3.org/TR/REC-xml-names/#NT-QName).
public struct QualifiedName: CustomStringConvertible, Hashable, ExpressibleByStringLiteral, Comparable {
  public typealias StringLiteralType = String
  
  public enum Prefix: Hashable, Comparable {
    case none
    case namespace(NoncolonizedName)
    public static let `default`: Prefix = .none
    
    public static func <(lhs: QualifiedName.Prefix, rhs: QualifiedName.Prefix) -> Bool {
      switch (lhs, rhs) {
      case (.none, .none):
        return false
      case (.none, .namespace):
        return true
      case (.namespace, .none):
        return false
      case (.namespace(let lName), .namespace(let rName)):
        return lName < rName
      }
    }
    
    fileprivate init?(_ string: String) {
      if string.isEmpty {
        self = .none
      } else if let name = NoncolonizedName(string) {
        self = .namespace(name)
      } else {
        return nil
      }
    }
    
    fileprivate init(_ ncName: NoncolonizedName) {
      self = .namespace(ncName)
    }
  }
  
  public var prefix: Prefix
  public var localName: NoncolonizedName
  
  public static func <(lhs: QualifiedName, rhs: QualifiedName) -> Bool {
    if lhs.prefix < rhs.prefix { return true }
    if lhs.prefix > rhs.prefix { return false }
    return lhs.localName < rhs.localName
  }
  
  public var description: String {
    switch self.prefix {
    case .none:
      return self.localName.description
    case .namespace(let prefix):
      return prefix.description + ":" + self.localName.description
    }
  }
  
  public init(prefix: Prefix = .none, localName: NoncolonizedName) {
    self.prefix = prefix
    self.localName = localName
  }
  
  public init?(_ string:String) {
    let splittedByColon = string.splitOnce(separator:":")
    
    if let localPartSource = splittedByColon.1 {
      guard let prefix = Prefix(String(splittedByColon.0)) else { return nil }
      guard let localPart = NoncolonizedName(String(localPartSource)) else { return nil }
      self.init(prefix:prefix, localName:localPart)
    } else {
      guard let localPart = NoncolonizedName(String(splittedByColon.0)) else { return nil }
      self.init(prefix:.none, localName:localPart)
    }
  }
  
  public init(stringLiteral:String) {
    guard let instance = QualifiedName(stringLiteral) else {
      fatalError("\"\(stringLiteral)\" is invalid for QName.")
    }
    self = instance
  }
}


/// Represents the name of [Attribute](https://www.w3.org/TR/REC-xml-names/#NT-Attribute).
public enum AttributeName: CustomStringConvertible, Hashable, ExpressibleByStringLiteral, Comparable {
  /// Namespace attribute
  case namespaceDeclaration(QualifiedName.Prefix)
  
  /// Ordinary attribute
  case attributeName(QualifiedName)
  
  public static func <(lhs: AttributeName, rhs: AttributeName) -> Bool {
    switch (lhs, rhs) {
    case (.namespaceDeclaration(let lPrefix), .namespaceDeclaration(let rPrefix)):
      return lPrefix < rPrefix
    case (.namespaceDeclaration, .attributeName):
      return true
    case (.attributeName, .namespaceDeclaration):
      return false
    case (.attributeName(let lName), .attributeName(let rName)):
      return lName < rName
    }
  }
  
  public var description: String {
    switch self {
    case .namespaceDeclaration(let prefix):
      switch prefix {
      case .none:
        return "xmlns"
      case .namespace(let ncName):
        return "xmlns:\(ncName.description)"
      }
    case .attributeName(let qName):
      return qName.description
    }
  }
  
  public init?(_ string:String) {
    if string == "xmlns" {
      self = .namespaceDeclaration(.default)
    } else if let qName = QualifiedName(string) {
      switch qName.prefix {
      case .namespace(let ncName) where ncName == "xmlns":
        self = .namespaceDeclaration(QualifiedName.Prefix(qName.localName))
      case .namespace:
        fallthrough
      case .none:
        self = .attributeName(qName)
      }
    } else {
      return nil
    }
  }
  
  public init(stringLiteral:String) {
    guard let instance = AttributeName(stringLiteral) else {
      fatalError("\"\(stringLiteral)\" is invalid for attribute name.")
    }
    self = instance
  }
}
