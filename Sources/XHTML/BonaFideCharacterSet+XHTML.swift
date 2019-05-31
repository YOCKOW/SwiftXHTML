/* *************************************************************************************************
 BonaFideCharacterSet+XHTML.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import BonaFideCharacterSet

private let _newlines: BonaFideCharacterSet = .init(charactersIn:[
  "\u{0A}", // LF
  "\u{0B}", // VT
  "\u{0C}", // FF
  "\u{0D}", // CR
  "\u{0D}\u{0A}", // CR+LF
  "\u{85}", // NEL
  "\u{2028}", // LS
  "\u{2029}", // PS
  ])

extension StringProtocol {
  internal var _splittedByNewlines: [String] {
    var result: [String] = []
    var line: String = ""
    for character: Character in self {
      line.append(character)
      if _newlines.contains(character) {
        result.append(line)
        line = ""
      }
    }
    if !line.isEmpty {
      result.append(line)
    }
    return result
  }
  
  internal var _endsWithNewline: Bool {
    if let lastCharacter = self.last, _newlines.contains(lastCharacter) {
      return true
    }
    return false
  }
}
