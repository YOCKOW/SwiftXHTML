/* *************************************************************************************************
 NamesTests.swift
   © 2018-2019,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import XHTML

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class NamesTests {
  @Test func test_NCName() {
    // Changed calling initializer due to [SR-10259](https://bugs.swift.org/browse/SR-10259).
    #expect(NoncolonizedName(rawValue:"名前") != nil)
    #expect(NoncolonizedName(rawValue:"接頭辞:名前") == nil)
  }

  @Test func test_QName() {
    let qName: QualifiedName = "接頭辞:名前"
    #expect(qName.prefix == .namespace("接頭辞"))
    #expect(qName.localName == "名前")
  }

  @Test func test_attributeName() {
    #expect(AttributeName("xmlns") == .namespaceDeclaration(.default))
    #expect(AttributeName("xmlns:mine") == .namespaceDeclaration(.namespace("mine")))
    #expect(AttributeName("p:n") == .attributeName("p:n"))
  }
}
#else
import XCTest

final class NamesTests: XCTestCase {
  func test_NCName() {
    // Changed calling initializer due to [SR-10259](https://bugs.swift.org/browse/SR-10259).
    XCTAssertNotNil(NoncolonizedName(rawValue:"名前"))
    XCTAssertNil(NoncolonizedName(rawValue:"接頭辞:名前"))
  }
  
  func test_QName() {
    let qName: QualifiedName = "接頭辞:名前"
    XCTAssertEqual(qName.prefix, .namespace("接頭辞"))
    XCTAssertEqual(qName.localName, "名前")
  }
  
  func test_attributeName() {
    XCTAssertEqual(AttributeName("xmlns"), .namespaceDeclaration(.default))
    XCTAssertEqual(AttributeName("xmlns:mine"), .namespaceDeclaration(.namespace("mine")))
    XCTAssertEqual(AttributeName("p:n"), .attributeName("p:n"))
  }
}
#endif
