/* *************************************************************************************************
 StringProtocol+AmpersandEncoding.swift
   © 2019-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet
import UnicodeSupplement

private let _lt = "&lt;".unicodeScalars
private let _gt = "&gt;".unicodeScalars
private let _amp = "&amp;".unicodeScalars
private let _quot = "&quot;".unicodeScalars
private let _apos = "&apos;".unicodeScalars
private let _table: [UnicodeScalar:String.UnicodeScalarView] = [
  "<":_lt,
  ">":_gt,
  "&":_amp,
  "\"":_quot,
  "'":_apos
]

extension Unicode.Scalar {
  internal func _forceAddingAmpersandEncoding() -> String {
    let hex = String(self.value, radix: 16, uppercase: true)
    switch hex.count {
    case 1, 3:
      return "&#x0\(hex);"
    default:
      return "&#x\(hex);"
    }
  }
}

private let _allowedCategories: Set<Unicode.GeneralCategory> = [
  .lowercaseLetter,
  .modifierLetter,
  .otherLetter,
  .titlecaseLetter,
  .uppercaseLetter,
  .spacingMark,
  .enclosingMark,
  .nonspacingMark,
  .decimalNumber,
  .letterNumber,
  .otherNumber,
  .connectorPunctuation,
  .dashPunctuation,
  .closePunctuation,
  .finalPunctuation,
  .initialPunctuation,
  .otherPunctuation,
  .openPunctuation,
  .currencySymbol,
  .modifierSymbol,
  .mathSymbol,
  .otherSymbol,
]

extension StringProtocol {
  internal func _addingAmpersandEncoding(
    whereAllowedUnicodeScalar isAllowed: (Unicode.Scalar) throws -> Bool
  ) rethrows -> String {
    var resultScalars = String.UnicodeScalarView()
    for scalar in self.unicodeScalars {
      if try isAllowed(scalar) {
        resultScalars.append(scalar)
      } else {
        if let escapedScalars = _table[scalar] {
          resultScalars.append(contentsOf: escapedScalars)
        } else {
          resultScalars.append(contentsOf: scalar._forceAddingAmpersandEncoding().unicodeScalars)
        }
      }
    }
    return String(resultScalars)
  }

  /// Returns a new string made from the receiver by replacing all scalars not in the specified set
  /// with ampersand-encoded characters.
  ///
  /// - parameter whereAllowedUnicodeScalar: A closure that returns true if its argument should not
  ///                                        be encoded; otherwise, false.
  ///                                        `<`, `>`, `&`, `"`, and `'` are always encoded
  ///                                        even if the closure returns `true`.
  public func addingAmpersandEncoding(whereAllowedUnicodeScalar isAllowed: (Unicode.Scalar) throws -> Bool) rethrows -> String {
    return try _addingAmpersandEncoding {
      try !_table.keys.contains($0) && isAllowed($0)
    }
  }
  
  /// Returns a new string made from the receiver by replacing all scalars not in the specified set
  /// with ampersand-encoded characters.
  ///
  /// - parameter allowedScalars: The scalars not replaced in the string.
  ///                             `<`, `>`, `&`, `"`, and `'` are always encoded
  ///                             even if the set contains them.
  public func addingAmpersandEncoding(withAllowedUnicodeScalars allowedScalars: UnicodeScalarSet) -> String {
    return self.addingAmpersandEncoding(whereAllowedUnicodeScalar: { allowedScalars.contains($0) })
  }
}

extension StringProtocol {
  internal func _addingAmpersandEncoding() -> String {
    return addingAmpersandEncoding {
      return $0 == "\u{20}" || _allowedCategories.contains($0.latestProperties.generalCategory)
    }
  }

  internal func _forceAddingAmpersandEncoding() -> String {
    return self.addingAmpersandEncoding { _ -> Bool in false }
  }

  internal func _addingMinimumAmpersandEncoding() -> String {
    return _addingAmpersandEncoding {
      switch $0 {
      case "<", ">", "&":
        return false
      default:
        return true
      }
    }
  }

  internal func _addingUntrimmedAmpersandEncoding() -> String {
    if let firstIndexOfNonSpace = self.firstIndex(where: { $0 != "\u{20}" }) {
      let endIndexOfNonSpace = self.index(after: self.lastIndex(where: { $0 != "\u{20}" })!)
      return (
        self[self.startIndex..<firstIndexOfNonSpace]._forceAddingAmpersandEncoding() +
        self[firstIndexOfNonSpace..<endIndexOfNonSpace]._addingAmpersandEncoding() +
        self[endIndexOfNonSpace..<self.endIndex]._forceAddingAmpersandEncoding()
      )
    } else {
      return self.unicodeScalars.reduce(into: "") { $0 += $1._forceAddingAmpersandEncoding() }
    }
  }
}
