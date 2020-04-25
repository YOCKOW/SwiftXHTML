/* *************************************************************************************************
 Errors.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif

/// Errors related to `Node`.
/// Mainly they may be thrown when the node is initialized with an instance of `XMLNode`.
public enum NodeError: Error, Equatable {
  case invalidAttributeName
  case invalidName
  case invalidProcessingInstructionName
  case invalidString
  case unexpectedNode(XMLNode)
}

public enum ElementError: LocalizedError, Equatable {
  case invalidLocalName(expected: NoncolonizedName, actual: NoncolonizedName)
  case invalidParent(expected: NoncolonizedName, actual: NoncolonizedName)
  
  public var errorDescription: String? {
    switch self {
    case .invalidLocalName(expected: let expected, actual: let actual):
      return "Invalid local name: expected \(expected) but got \(actual)."
    case .invalidParent(expected: let expected, actual: let actual):
      return "Invalid parent: expected \(expected) but got \(actual)."
    }
  }
}
