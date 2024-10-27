/* *************************************************************************************************
 AttributesTests.swift
   © 2018,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

@testable import XHTML

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class AttributesTests {
  @Test func test_initialzation() {
    let dic:[String:String] = ["xmlns":"http://foo/bar",
                               "xmlns:myns":"http://my/ns",
                               "name":"value"]
    let attributes = Attributes(dic)

    #expect(attributes["xmlns"] == "http://foo/bar")
    #expect(attributes["xmlns:myns"] == "http://my/ns")
    #expect(attributes["name"] == "value")
    #expect(attributes[localName:"name", uri:nil] == "value")
  }

  @Test func test_namespace() {
    let attributes: Attributes = [
      "xmlns":"http://default/namespace",
      "xmlns:myns":"http://my/ns",
      "name":"value",
      "myns:name":"my value"
    ]

    // TODO: Add more tests
    #expect(attributes[localName:"name", uri:"http://default/namespace"] == "value")
    #expect(attributes[localName:"name", uri:"http://my/ns"] == "my value")
    #expect(attributes[localName:"name", uri:"http://other/ns"] == nil)
  }
}
#else
import XCTest

final class AttributesTests: XCTestCase {
  func test_initialzation() {
    let dic:[String:String] = ["xmlns":"http://foo/bar",
                               "xmlns:myns":"http://my/ns",
                               "name":"value"]
    let attributes = Attributes(dic)
    
    XCTAssertEqual(attributes["xmlns"], "http://foo/bar")
    XCTAssertEqual(attributes["xmlns:myns"], "http://my/ns")
    XCTAssertEqual(attributes["name"], "value")
    XCTAssertEqual(attributes[localName:"name", uri:nil], "value")
  }
  
  func test_namespace() {
    let attributes: Attributes = [
      "xmlns":"http://default/namespace",
      "xmlns:myns":"http://my/ns",
      "name":"value",
      "myns:name":"my value"
    ]
    
    // TODO: Add more tests
    XCTAssertEqual(attributes[localName:"name", uri:"http://default/namespace"], "value")
    XCTAssertEqual(attributes[localName:"name", uri:"http://my/ns"], "my value")
    XCTAssertNil(attributes[localName:"name", uri:"http://other/ns"])
  }
}
#endif
