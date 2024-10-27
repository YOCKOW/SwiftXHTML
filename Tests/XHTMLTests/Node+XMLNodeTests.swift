/* *************************************************************************************************
 Node+XMLNodeTests.swift
   © 2019-2020,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
#if canImport(FoundationXML)
import FoundationXML
#endif
@testable import XHTML


#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class Node_XMLNodeTests {
  func test_attributes() throws {
    let xmlElement = try XMLElement(xmlString:
      #"""
        <element
          xmlns="http://default/ns"
          xmlns:prefix="http://prefix/ns"
          prefix:local="value" noPrefix="" />
      """#
    )
    let attributes = Attributes(attributesOf: xmlElement)
    #expect(attributes[.namespaceDeclaration(.default)] == "http://default/ns")
    #expect(attributes[.namespaceDeclaration(.namespace("prefix"))] == "http://prefix/ns")
    #expect(attributes[.attributeName("prefix:local")] == "value")
    #expect(attributes[.attributeName("noPrefix")] == "")
  }

  @Test func test_comment() throws {
    let commentXMLNode = try #require(XMLNode.comment(withStringValue: "comment") as? XMLNode)
    let comment = try Comment(_xmlNode: commentXMLNode)
    #expect(comment.text == "comment")
  }

  @Test func test_processingInstruction() throws {
    let piXMLNode = try #require(
      XMLNode.processingInstruction(withName: "name", stringValue: "value") as? XMLNode
    )
    let pi = try ProcessingInstruction(_xmlNode: piXMLNode)
    #expect(pi.target == "name")
    #expect(pi.content == "value")
  }

  @Test func test_text() throws {
    let textXMLNode = try #require(XMLNode.text(withStringValue: "<my text>") as? XMLNode)
    let text = try Text(_xmlNode: textXMLNode)
    #expect(text.text == "<my text>")
  }

  @Test func test_node() throws {
    let xmlNode = try XMLElement(xmlString: #"""
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head><title>my page</title></head>
        <body>  text1  <a href="uri">link</a>  text2  </body>
      </html>
    """#)
    guard case let html as HTMLElement = try Node(xmlNode) else { Issue.record("Not HTML."); return }
    #expect(html.children.count == 2)

    guard case let head as HeadElement = html.children.first else { Issue.record("Not HEAD."); return }
    #expect((head.children.first as? TitleElement)?.name == "title")
    #expect((head.children.first as? TitleElement)?.title == "my page")

    guard case let body as BodyElement = html.children.last else { Issue.record("Not BODY."); return }
    #expect(body.children.count == 3)
    #expect((body.children.first as? Text)?.text == "text1")
    #expect((body.children.last as? Text)?.text == "text2")

    guard case let anchor as AnchorElement = body.children[1] else { Issue.record("Not A."); return }
    #expect(anchor.hypertextReference == "uri")
    #expect((anchor.children.first as? Text)?.text == "link")
  }
}
#else
import XCTest

final class Node_XMLNodeTests: XCTestCase {
  func test_attributes() throws {
    let xmlElement = try XMLElement(xmlString:
      #"""
        <element
          xmlns="http://default/ns"
          xmlns:prefix="http://prefix/ns"
          prefix:local="value" noPrefix="" />
      """#
    )
    let attributes = Attributes(attributesOf: xmlElement)
    XCTAssertEqual(attributes[.namespaceDeclaration(.default)], "http://default/ns")
    XCTAssertEqual(attributes[.namespaceDeclaration(.namespace("prefix"))], "http://prefix/ns")
    XCTAssertEqual(attributes[.attributeName("prefix:local")], "value")
    XCTAssertEqual(attributes[.attributeName("noPrefix")], "")
  }
  
  func test_comment() throws {
    let commentXMLNode = try XCTUnwrap(XMLNode.comment(withStringValue: "comment") as? XMLNode)
    let comment = try Comment(_xmlNode: commentXMLNode)
    XCTAssertNotNil(comment)
    XCTAssertEqual(comment.text, "comment")
  }
  
  func test_processingInstruction() throws {
    let piXMLNode = try XCTUnwrap(XMLNode.processingInstruction(withName: "name", stringValue: "value") as? XMLNode)
    let pi = try ProcessingInstruction(_xmlNode: piXMLNode)
    XCTAssertNotNil(pi)
    XCTAssertEqual(pi.target, "name")
    XCTAssertEqual(pi.content, "value")
  }
  
  func test_text() throws {
    let textXMLNode = try XCTUnwrap(XMLNode.text(withStringValue: "<my text>") as? XMLNode)
    let text = try Text(_xmlNode: textXMLNode)
    XCTAssertNotNil(text)
    XCTAssertEqual(text.text, "<my text>")
  }
  
  func test_node() throws {
    let xmlNode = try XMLElement(xmlString: #"""
      <html xmlns="http://www.w3.org/1999/xhtml">
        <head><title>my page</title></head>
        <body>  text1  <a href="uri">link</a>  text2  </body>
      </html>
    """#)
    guard case let html as HTMLElement = try Node(xmlNode) else { XCTFail("Not HTML."); return }
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
#endif
