/* *************************************************************************************************
 Node+XMLNode.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation

extension Comment {
  public convenience init?(_ xmlNode: XMLNode) {
    // Requires a workaround for [SR-10717](https://bugs.swift.org/browse/SR-10717)
    #if os(macOS) || swift(>=5.1)
    guard xmlNode.kind == .comment else { return nil }
    self.init(xmlNode.stringValue!)
    #else
    let xmlString = xmlNode.xmlString
    guard xmlString.hasPrefix("<!--") && xmlString.hasSuffix("-->") else { return nil }
    let startIndexOfText = xmlString.index(xmlString.startIndex, offsetBy: 4)
    let endIndexOfText = xmlString.index(xmlString.endIndex, offsetBy: -3)
    self.init(String(xmlString[startIndexOfText..<endIndexOfText]))
    #endif
  }
}
