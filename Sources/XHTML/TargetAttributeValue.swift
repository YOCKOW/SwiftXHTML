/* *************************************************************************************************
 TargetAttributeValue.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
/// Represents a value of "target"
public enum TargetAttributeValue: Hashable, RawRepresentable, ExpressibleByStringInterpolation {
  public typealias StringLiteralType = String
  public typealias RawValue = String
  
  case blank
  case parent
  case `self`
  case top
  
  case name(String)
  
  public init(rawValue: String) {
    switch rawValue {
    case "_blank":
      self = .blank
    case "_parent":
      self = .parent
    case "_self":
      self = .self
    case "_top":
      self = .top
    default:
      self = .name(rawValue)
    }
  }
  
  public init(stringLiteral: String) {
    self.init(rawValue: stringLiteral)
  }
  
  public var rawValue: String {
    switch self {
    case .blank:
      return "_blank"
    case .parent:
      return "_parent"
    case .self:
      return "_self"
    case .top:
      return "_top"
    case .name(let name):
      return name
    }
  }
}

public protocol TargetHoldableElement where Self: Element {
  var target: TargetAttributeValue? { get set }
}

extension TargetHoldableElement {
  public var target: TargetAttributeValue? {
    get {
      return self.attributes["target"].map(TargetAttributeValue.init(rawValue:))
    }
    set {
      self.attributes["target"] = newValue?.rawValue
    }
  }
}
