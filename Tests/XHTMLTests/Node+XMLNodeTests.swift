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




