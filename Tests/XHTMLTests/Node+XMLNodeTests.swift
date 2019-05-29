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
    XCTAssertEqual(attributes?[.namespaceDeclaration(.default)], "http://default/ns")
    XCTAssertEqual(attributes?[.namespaceDeclaration(.namespace("prefix"))], "http://prefix/ns")
    XCTAssertEqual(attributes?[.attributeName("prefix:local")], "value")
    XCTAssertEqual(attributes?[.attributeName("noPrefix")], "")
  }
  
  func test_comment() {
    let commentXMLNode = XMLNode.comment(withStringValue: "comment") as! XMLNode
    let comment = Comment(_xmlNode: commentXMLNode)
    XCTAssertNotNil(comment)
    XCTAssertEqual(comment?.text, "comment")
  }
  
  func test_processingInstruction() {
    let piXMLNode = XMLNode.processingInstruction(withName: "name", stringValue: "value") as! XMLNode
    let pi = ProcessingInstruction(_xmlNode: piXMLNode)
    XCTAssertNotNil(pi)
    XCTAssertEqual(pi?.target, "name")
    XCTAssertEqual(pi?.content, "value")
  }
  
  func test_text() {
    let textXMLNode = XMLNode.text(withStringValue: "<my text>") as! XMLNode
    let text = Text(_xmlNode: textXMLNode)
    XCTAssertNotNil(text)
    XCTAssertEqual(text?.text, "<my text>")
  }
  
  func test_node() {
    let xmlNode = try! XMLElement(xmlString: #"""
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head><title>my page</title></head>
        <body>text1<a href="uri">link</a>text2</body>
      </html>
    """#)
    guard case let html as HTMLElement = Node(xmlNode) else { XCTFail("Not HTML."); return }
    XCTAssertEqual(html.children.count, 2)
    
    guard case let head as HeadElement = html.children.first else { XCTFail("Not HEAD."); return }
    XCTAssertEqual((head.children.first as? TitleElement)?.name, "title")
    XCTAssertEqual((head.children.first as? TitleElement)?.title, "my page")
    
    guard case let body as BodyElement = html.children.last else { XCTFail("Not BODY."); return }
    XCTAssertEqual(body.children.count, 3)
    XCTAssertEqual((body.children.first as? Text)?.text, "text1")
    XCTAssertEqual((body.children.last as? Text)?.text, "text2")
    
    guard case let anchor as AnchorElement = body.children[1] else { XCTFail("Not A."); return }
    XCTAssertEqual(anchor.hypertextReference, "uri")
    XCTAssertEqual((anchor.children.first as? Text)?.text, "link")
  }
}




