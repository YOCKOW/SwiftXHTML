/* *************************************************************************************************
 ProcessingInstructionTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

import NetworkGear

final class ProcessingInstructionTests: XCTestCase {
  func test_XMLStyleSheet() throws {
    let pi = XMLStyleSheet(type: try XCTUnwrap(MIMEType("text/css")), hypertextReference:"style.css")
    XCTAssertEqual(pi.xhtmlString, "<?xml-stylesheet type=\"text/css\" href=\"style.css\"?>")
  }
}




