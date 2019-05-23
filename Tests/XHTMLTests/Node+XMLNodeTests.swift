/* *************************************************************************************************
 Node+XMLNodeTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

import Foundation

final class Node_XMLNodeTests: XCTestCase {
  func test_attributes() {
    let xmlElement = try! XMLElement(xmlString:
      #"""
        <element
          xmlns="http://default/ns"
          xmlns:prefix="http://prefix/ns"
          prefix:local="value" noPrefix="" />
      """#
    )
    let attributes = Attributes(attributesOf:xmlElement)
    XCTAssertEqual(attributes?[.defaultNamespace], "http://default/ns")
    XCTAssertEqual(attributes?[.userDefinedNamespace("prefix")], "http://prefix/ns")
    XCTAssertEqual(attributes?[.attributeName("prefix:local")], "value")
    XCTAssertEqual(attributes?[.attributeName("noPrefix")], "")
  }
  
  func test_comment() {
    let commentXMLNode = XMLNode.comment(withStringValue: "comment") as! XMLNode
    let comment = Comment(commentXMLNode)
    XCTAssertNotNil(comment)
    XCTAssertEqual(comment?.text, "comment")
  }
  
  func test_processingInstruction() {
    let piXMLNode = XMLNode.processingInstruction(withName: "name", stringValue: "value") as! XMLNode
    let pi = ProcessingInstruction(piXMLNode)
    XCTAssertNotNil(pi)
    XCTAssertEqual(pi?.target, "name")
    XCTAssertEqual(pi?.content, "value")
  }
}




