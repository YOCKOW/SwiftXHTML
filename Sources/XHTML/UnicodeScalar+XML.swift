/* *************************************************************************************************
 UnicodeScalar+XML.swift
   © 2018,2023 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import Ranges

extension Unicode.Scalar {
  internal var isAllowedInXML: Bool {
    switch value {
    case 0x09, 0x0A, 0x0D, 0x0020...0xD7FF, 0xE000...0xFFFD, 0x10000...0x10FFFF:
      return true
    default:
      return false
    }
  }

  internal var isXMLWhitespace: Bool {
    switch value {
    case 0x20, 0x09, 0x0D, 0x0A:
      return true
    default:
      return false
    }
  }

  internal var isXMLNameStart: Bool {
    switch self {
    case ":", "_", "A"..."Z", "a"..."z",
      "\u{C0}"..."\u{D6}", "\u{D8}"..."\u{F6}", "\u{F8}"..."\u{2FF}",
      "\u{370}"..."\u{37D}", "\u{37F}"..."\u{1FFF}", "\u{200C}"..."\u{200D}",
      "\u{2070}"..."\u{218F}", "\u{2C00}"..."\u{2FEF}", "\u{3001}"..."\u{D7FF}",
      "\u{F900}"..."\u{FDCF}", "\u{FDF0}"..."\u{FFFD}", "\u{10000}"..."\u{EFFFF}":
      return true
    default:
      return false
    }
  }

  internal var isAllowedInXMLName: Bool {
    if isXMLNameStart {
      return true
    }

    switch self {
    case "-", ".", "\u{B7}", "0"..."9", "\u{0300}"..."\u{036F}", "\u{203F}"..."\u{2040}":
      return true
    default:
      return false
    }
  }

  internal var isAllowedInXMLNoncolonizedName: Bool {
    return self != ":" && isAllowedInXMLName
  }
}
