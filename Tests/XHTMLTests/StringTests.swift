/* *************************************************************************************************
 StringTests.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

final class StringTests: XCTestCase {
  func test_ampersandEncoding() {
    let string = #"if (x < y && y > z) printf("%d", y);\#n"#
    XCTAssertEqual(string._addingAmpersandEncoding(),
                   #"if (x &lt; y &amp;&amp; y &gt; z) printf(&quot;%d&quot;, y);&#x0A;"#)
    
    let textNode = Text("  TEXT NODE  ")
    XCTAssertEqual(textNode.xhtmlString, "&#x20;&#x20;TEXT NODE&#x20;&#x20;")
  }
}
