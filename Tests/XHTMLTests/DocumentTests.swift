/* *************************************************************************************************
 DocumentTests.swift
   © 2017-2018 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import XCTest
@testable import XHTML

import TestResources

private let simpleXHTML5_data = TestResources.shared.data(for:"XHTML/SimpleXHTML5.utf8.xhtml")!
private let xhtml5_data = TestResources.shared.data(for:"XHTML/XHTML5.utf8.xhtml")!
private let xhtml5_utf16be_data = TestResources.shared.data(for:"XHTML/XHTML5.utf16be.xhtml")!

final class DocumentTests: XCTestCase {
  func test_detectXHTMLInfo() {
    let infoOfSimpleXHTML5 = simpleXHTML5_data.xhtmlInfo
    XCTAssertTrue(infoOfSimpleXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version:.v5_2),
                  "\(infoOfSimpleXHTML5)")
    
    
    let infoOfXHTML5 = xhtml5_data.xhtmlInfo
    XCTAssertTrue(infoOfXHTML5 == (xmlVersion:"1.0", stringEncoding:.utf8, version:nil),
                  "\(infoOfXHTML5)")
    
    let infoOfXHTML5UTF16BE = xhtml5_utf16be_data.xhtmlInfo
    XCTAssertTrue(infoOfXHTML5UTF16BE == (xmlVersion:"1.0", stringEncoding:.utf16BigEndian, version:nil),
                  "\(infoOfXHTML5UTF16BE)")
  }
  
  func test_initialization() {
    let root = HTMLElement(name:"html")
    let document = Document(rootElement:root)
    XCTAssertEqual(
      document.xhtmlString,
      """
      <?xml version="1.0" encoding="utf-8"?>
      \(Version.v5._documentType!)
      \(root.xhtmlString)
      """)
  }
  
  func test_tree() {
    let document = Document(
      rootElement:.init(name:"html", attributes:[:], children:[
        .head(children:[.title("My XHTML.")]),
        .body(children:[])
      ])
    )
    
    XCTAssertEqual(document.title, "My XHTML.")
  }
  
  func test_title() {
    let document = Document(rootElement: .init(name:"html"))
    XCTAssertNil(document.title)
    
    document.title = "title"
    XCTAssertEqual(document.title, "title")
  }
  
  func test_template() {
    let template = Document.template(
      author: "It's me.",
      description: "My page.",
      keywords: ["I", "my", "me"],
      title: "My first XHTML5."
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
}

