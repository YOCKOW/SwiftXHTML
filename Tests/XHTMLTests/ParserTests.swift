/* *************************************************************************************************
 ParserTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

import TestResources

final class ParserTests: XCTestCase {
  func test_parseSimpleXHTML5() throws {
    let document = try Parser.parse(try XCTUnwrap(TestResources.shared.data(for:"XHTML/SimpleXHTML5.utf8.xhtml")))
    XCTAssertEqual(document.title, "XHTML5")
  }
  
  func test_errors_document() {
    func _test_localFile<E>(at relativePath: String, expectedError: E, file: StaticString = #file, line: UInt = #line) where E: Error {
      do {
        let _ = try Parser.parse(TestResources.shared.data(for:"XHTML/InvalidXHTML/" + relativePath)!)
        XCTFail("No error was thrown.", file: file, line: line)
      } catch {
        switch (error, expectedError) {
        case (let parserError as Parser.Error, let expectedError as Parser.Error):
          XCTAssertEqual(parserError, expectedError, file: file, line: line)
        case (let elementError as ElementError, let expectedError as ElementError):
          XCTAssertEqual(elementError, expectedError, file: file, line: line)
        default:
          XCTFail("Unexpected Error: \(error.localizedDescription)", file:file, line:line)
          return
        }
      }
    }
    
    _test_localFile(at: "RootElementIsNotHTML.xhtml", expectedError: Parser.Error.rootElementIsNotHTML)
  }
}



