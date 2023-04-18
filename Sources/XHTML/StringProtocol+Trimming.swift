/* *************************************************************************************************
 StringProtocol+Trimming.swift
   © 2023 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

private extension BidirectionalCollection {
  func _trimming(where isElement: (Element) throws -> Bool) rethrows -> SubSequence {
    guard let firstIndex = try self.firstIndex(where: { try !isElement($0) }),
          let lastIndex = try self.lastIndex(where: { try !isElement($0) }) else {
      return self[startIndex..<startIndex]
    }
    return self[firstIndex...lastIndex]
  }
}

extension StringProtocol {
  internal func _trimmingCharacters(where isCharacter: (Character) throws -> Bool) rethrows -> SubSequence {
    return try _trimming(where: isCharacter)
  }

  internal func _trimmingUnicodeScalars(where isUnicodeScalar: (Unicode.Scalar) throws -> Bool) rethrows -> String {
    return try String(String.UnicodeScalarView(self.unicodeScalars._trimming(where: isUnicodeScalar)))
  }
}
