/* *************************************************************************************************
 ElementError.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

public enum ElementError: LocalizedError {
  case invalidLocalName(expected: NoncolonizedName, actual: NoncolonizedName)
  case invalidParent(expected: NoncolonizedName, actual: NoncolonizedName)
}

extension ElementError {
  public var errorDescription: String? {
    switch self {
    case .invalidLocalName(expected: let expected, actual: let actual):
      return "Invalid local name: expected \(expected) but got \(actual)."
    case .invalidParent(expected: let expected, actual: let actual):
      return "Invalid parent: expected \(expected) but got \(actual)."
    }
  }
}
