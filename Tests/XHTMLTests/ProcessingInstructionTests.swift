/* *************************************************************************************************
 ProcessingInstructionTests.swift
   © 2019,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import NetworkGear
@testable import XHTML


#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class ProcessingInstructionTests {
  @Test func test_XMLStyleSheet() throws {
    let pi = XMLStyleSheet(type: try #require(MIMEType("text/css")), hypertextReference:"style.css")
    #expect(pi.xhtmlString == "<?xml-stylesheet type=\"text/css\" href=\"style.css\"?>")
  }
}
#else
import XCTest

final class ProcessingInstructionTests: XCTestCase {
  func test_XMLStyleSheet() throws {
    let pi = XMLStyleSheet(type: try XCTUnwrap(MIMEType("text/css")), hypertextReference:"style.css")
    XCTAssertEqual(pi.xhtmlString, "<?xml-stylesheet type=\"text/css\" href=\"style.css\"?>")
  }
}
#endif
