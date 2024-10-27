/* *************************************************************************************************
 Version.swift
   © 2018,2023-2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

public enum HTML4_01Version: Hashable, Sendable {
  /// Corresponding to strict HTML 4.01.
  case strict
  
  /// Corresponding to HTML 4.01 Transitional
  case transitional
  
  /// Corresponding to HTML 4.01 Frameset
  case frameset
}

/// The version of XHTML.
public enum Version: Hashable, Sendable {
  /// XHTML 1.0
  case v1_0(HTML4_01Version)
  
  /// XHTML 1.1
  case v1_1
  
  /// XHTML Basic 1.0
  case basic1_0
  
  /// XHTML Basic 1.1
  case basic1_1
  
  /// XHTML Mobile Profile 1.0
  case mobileProfile1_0
  
  /// XHTML Mobile Profile 1.1
  case mobileProfile1_1
  
  /// XHTML Mobile Profile 1.2
  case mobileProfile1_2
  
  /// XHTML Mobile Profile 1.3
  case mobileProfile1_3
  
  /// XHTML 1.2
  // case v1_2
  
  /// XHTML 2.0
  // case v2_0
  
  /// XHTML5
  case v5
  
  /// XHTML5.1
  case v5_1
  
  /// XHTML5.2
  case v5_2
  
  /// Unspecified
  case unspecified
}

extension Version {
  public static let latest: Version = .v5_2
}

extension Version {
  internal var _documentType: String {
    switch self {
    case .v1_0(let hVersion):
      switch hVersion {
      case .strict:
        return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Strict//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-strict.dtd\">"
      case .transitional:
        return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">"
      case .frameset:
        return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.0 Frameset//EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-frameset.dtd\">"
      }
    case .v1_1:
      return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML 1.1//EN\" \"http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd\">"
    case .basic1_0:
      return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML Basic 1.0//EN\" \"http://www.w3.org/TR/xhtml-basic/xhtml-basic10.dtd\">"
    case .basic1_1:
      return "<!DOCTYPE html PUBLIC \"-//W3C//DTD XHTML Basic 1.1//EN\" \"http://www.w3.org/TR/xhtml-basic/xhtml-basic11.dtd\">"
    case .mobileProfile1_0:
      return "<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.0//EN\" \"http://www.wapforum.org/DTD/xhtml-mobile10.dtd\">"
    case .mobileProfile1_1:
      return "<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.1//EN\" \"http://www.openmobilealliance.org/tech/DTD/xhtml-mobile11.dtd\">"
    case .mobileProfile1_2:
      return "<!DOCTYPE html PUBLIC \"-//WAPFORUM//DTD XHTML Mobile 1.2//EN\" \"http://www.openmobilealliance.org/tech/DTD/xhtml-mobile12.dtd\">"
    case .mobileProfile1_3:
      return Version.basic1_1._documentType
    default:
      return "<!DOCTYPE html>"
    }
  }
}

private let _doctypesWithoutSpaces:[String:Version] = [
  "<!doctypehtmlpublic\"-//w3c//dtdxhtml1.0strict//en\"\"http://www.w3.org/tr/xhtml1/dtd/xhtml1-strict.dtd\">": .v1_0(.strict),
  "<!doctypehtmlpublic\"-//w3c//dtdxhtml1.0transitional//en\"\"http://www.w3.org/tr/xhtml1/dtd/xhtml1-transitional.dtd\">": .v1_0(.transitional),
  "<!doctypehtmlpublic\"-//w3c//dtdxhtml1.0frameset//en\"\"http://www.w3.org/tr/xhtml1/dtd/xhtml1-frameset.dtd\">": .v1_0(.frameset),
  "<!doctypehtmlpublic\"-//w3c//dtdxhtml1.1//en\"\"http://www.w3.org/tr/xhtml11/dtd/xhtml11.dtd\">": .v1_1,
  "<!doctypehtmlpublic\"-//w3c//dtdxhtmlbasic1.0//en\"\"http://www.w3.org/tr/xhtml-basic/xhtml-basic10.dtd\">": .basic1_0,
  "<!doctypehtmlpublic\"-//w3c//dtdxhtmlbasic1.1//en\"\"http://www.w3.org/tr/xhtml-basic/xhtml-basic11.dtd\">": .basic1_1,
  "<!doctypehtmlpublic\"-//wapforum//dtdxhtmlmobile1.0//en\"\"http://www.wapforum.org/dtd/xhtml-mobile10.dtd\">": .mobileProfile1_0,
  "<!doctypehtmlpublic\"-//wapforum//dtdxhtmlmobile1.1//en\"\"http://www.openmobilealliance.org/tech/dtd/xhtml-mobile11.dtd\">": .mobileProfile1_1,
  "<!doctypehtmlpublic\"-//wapforum//dtdxhtmlmobile1.2//en\"\"http://www.openmobilealliance.org/tech/dtd/xhtml-mobile12.dtd\">": .mobileProfile1_2,
  "<!doctypehtml>": .unspecified,
]
extension String {
  fileprivate func _removeWhitespacesAndNewlines() -> String {
    var newScalars = UnicodeScalarView()
    for scalar in self.unicodeScalars {
      if scalar.isXMLWhitespace { continue }
      newScalars.append(scalar)
    }
    return String(newScalars)
  }
}
extension Version {
  internal init?(_documentType: String) {
    let lowercasedDoctypeWithoutSpaces = _documentType._removeWhitespacesAndNewlines().lowercased()
    guard let version = _doctypesWithoutSpaces[lowercasedDoctypeWithoutSpaces] else { return nil }
    self = version
  }
}
