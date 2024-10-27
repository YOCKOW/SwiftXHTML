/* *************************************************************************************************
 DocumentTests.swift
   © 2017-2018,2023-2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import Foundation
import TestResources
@testable import XHTML

private let simpleXHTML5_data = TestResources.shared.data(for:"XHTML/SimpleXHTML5.utf8.xhtml")
private let xhtml5_data = TestResources.shared.data(for:"XHTML/XHTML5.utf8.xhtml")
private let xhtml5_utf16be_data = TestResources.shared.data(for:"XHTML/XHTML5.utf16be.xhtml")

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class DocumentTests {
  @Test func test_detectXHTMLInfo() throws {
    let infoOfSimpleXHTML5 = try #require(simpleXHTML5_data).xhtmlInfo
    #expect(
      infoOfSimpleXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version: .unspecified),
      "\(infoOfSimpleXHTML5)"
    )


    let infoOfXHTML5 = try #require(xhtml5_data).xhtmlInfo
    #expect(
      infoOfXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version:nil),
      "\(infoOfXHTML5)"
    )

    let infoOfXHTML5UTF16BE = try #require(xhtml5_utf16be_data).xhtmlInfo
    #expect(
      infoOfXHTML5UTF16BE == (xmlVersion:"1.0", stringEncoding:.utf16BigEndian, version:nil),
      "\(infoOfXHTML5UTF16BE)"
    )
  }

  @Test func test_initialization() throws {
    let root = try HTMLElement(name:"html")
    let document = Document(rootElement:root)
    #expect(
      document.xhtmlString ==
      """
      <?xml version="1.0" encoding="utf-8"?>
      \(Version.v5._documentType)
      \(root.xhtmlString)
      """
    )
  }

  @Test func test_tree() throws {
    let document = Document(
      rootElement: try .init(name:"html", attributes:[:], children:[
        .head(children:[.title("My XHTML.")]),
        .body(children:[])
      ])
    )
    #expect(document.title == "My XHTML.")
  }

  @Test func test_title() throws {
    let document = Document(rootElement: try .init(name:"html"))
    #expect(document.title == nil)

    document.title = "title"
    #expect(document.title == "title")
  }

  @Test func test_template() throws {
    let template = Document.template(
      author: "It's me.",
      description: "My page.",
      keywords: ["I", "my", "me"],
      title: "My first XHTML5.",
      contents: []
    )

    let head = try #require(template.rootElement.head)
    #expect(head.author == "It's me.")
    #expect(head.description == "My page.")
    #expect(head.keywords == ["I", "my", "me"])
    #expect(template.title == "My first XHTML5.")

    let body = try #require(template.rootElement.body)
    #expect(body.children.isEmpty)
  }

  @Test func test_xhtmlToHTML() throws {
    let xhtml = """
    <?xml version="1.0" encoding="UTF-8"?>
    <xhtml:html xmlns:xhtml="http://www.w3.org/1999/xhtml" xhtml:lang="ja">
      <xhtml:head>
        <xhtml:title xml:id="title">XHTML5</xhtml:title>
        <xhtml:script>window.alert("XHTML5?")</xhtml:script>
      </xhtml:head>
      <xhtml:body>
        <xhtml:div id="main" xml:id="xml-main">I am also XHTML5.</xhtml:div>
      </xhtml:body>
    </xhtml:html>
    """

    let document = try Parser.parse(Data(xhtml.utf8))
    #expect(
      try document.prettyHTMLString ==
      """
      <!DOCTYPE html>
      <html lang="ja">
        <head>
          <title>XHTML5</title>
          <script>window.alert("XHTML5?")</script>
        </head>
        <body><div id="main">I am also XHTML5.</div></body>
      </html>

      """
    )
  }
}
#else
import XCTest

final class DocumentTests: XCTestCase {
  func test_detectXHTMLInfo() throws {
    let infoOfSimpleXHTML5 = try XCTUnwrap(simpleXHTML5_data).xhtmlInfo
    XCTAssertTrue(infoOfSimpleXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version: .unspecified),
                  "\(infoOfSimpleXHTML5)")
    
    
    let infoOfXHTML5 = try XCTUnwrap(xhtml5_data).xhtmlInfo
    XCTAssertTrue(infoOfXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version:nil),
                  "\(infoOfXHTML5)")
    
    let infoOfXHTML5UTF16BE = try XCTUnwrap(xhtml5_utf16be_data).xhtmlInfo
    XCTAssertTrue(infoOfXHTML5UTF16BE == (xmlVersion:"1.0", stringEncoding:.utf16BigEndian, version:nil),
                  "\(infoOfXHTML5UTF16BE)")
  }
  
  func test_initialization() throws {
    let root = try HTMLElement(name:"html")
    let document = Document(rootElement:root)
    XCTAssertEqual(
      document.xhtmlString,
      """
      <?xml version="1.0" encoding="utf-8"?>
      \(Version.v5._documentType)
      \(root.xhtmlString)
      """)
  }
  
  func test_tree() throws {
    let document = Document(
      rootElement: try .init(name:"html", attributes:[:], children:[
        .head(children:[.title("My XHTML.")]),
        .body(children:[])
      ])
    )
    
    XCTAssertEqual(document.title, "My XHTML.")
  }
  
  func test_title() throws {
    let document = Document(rootElement: try .init(name:"html"))
    XCTAssertNil(document.title)
    
    document.title = "title"
    XCTAssertEqual(document.title, "title")
  }
  
  func test_template() {
    let template = Document.template(
      author: "It's me.",
      description: "My page.",
      keywords: ["I", "my", "me"],
      title: "My first XHTML5.",
      contents: []
    )
    
    let head = template.rootElement.head
    XCTAssertNotNil(head)
    XCTAssertEqual(head?.author, "It's me.")
    XCTAssertEqual(head?.description, "My page.")
    XCTAssertEqual(head?.keywords, ["I", "my", "me"])
    XCTAssertEqual(template.title, "My first XHTML5.")
    
    let body = template.rootElement.body
    XCTAssertNotNil(body)
    XCTAssertTrue(body?.children.isEmpty == true)
  }

  func test_xhtmlToHTML() throws {
    let xhtml = """
    <?xml version="1.0" encoding="UTF-8"?>
    <xhtml:html xmlns:xhtml="http://www.w3.org/1999/xhtml" xhtml:lang="ja">
      <xhtml:head>
        <xhtml:title xml:id="title">XHTML5</xhtml:title>
        <xhtml:script>window.alert("XHTML5?")</xhtml:script>
      </xhtml:head>
      <xhtml:body>
        <xhtml:div id="main" xml:id="xml-main">I am also XHTML5.</xhtml:div>
      </xhtml:body>
    </xhtml:html>
    """

    let document = try Parser.parse(Data(xhtml.utf8))
    XCTAssertEqual(try document.prettyHTMLString, """
    <!DOCTYPE html>
    <html lang="ja">
      <head>
        <title>XHTML5</title>
        <script>window.alert("XHTML5?")</script>
      </head>
      <body><div id="main">I am also XHTML5.</div></body>
    </html>

    """)
  }
}
#endif
