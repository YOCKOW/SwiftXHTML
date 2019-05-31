/* *************************************************************************************************
 CommentTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

final class CommentTests: XCTestCase {
  func test_comment() {
    let comment = Comment("Comment")
    XCTAssertEqual(comment?.xhtmlString, "<!--Comment-->")
    XCTAssertNil(Comment("A -- B"))
    XCTAssertNil(Comment("A+B-"))
  }
  
  func test_prettyXHTMLString() {
    let comment = Comment("line0\r\nline1\r\n")
    XCTAssertEqual(comment?.prettyXHTMLString, "<!--\n\(_indent)line0\r\n\(_indent)line1\r\n-->")
    
    let comment_oneLine = Comment("one line")
    XCTAssertEqual(comment_oneLine?.prettyXHTMLString, "<!--one line-->")
    
    let comment_oneLineWithNewline = Comment("one line\r")
    XCTAssertEqual(comment_oneLineWithNewline?.prettyXHTMLString, "<!--\n\(_indent)one line\r-->")
  }
}



