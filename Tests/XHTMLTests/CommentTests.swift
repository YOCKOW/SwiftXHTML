/* *************************************************************************************************
 CommentTests.swift
   © 2019-2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

import StringComposition

final class CommentTests: XCTestCase {
  func test_comment() throws {
    let comment = try Comment("Comment")
    XCTAssertEqual(comment.xhtmlString, "<!--Comment-->")
    XCTAssertThrowsError(try Comment("A -- B"))
    XCTAssertThrowsError(try Comment("A+B-"))
  }
  
  func test_prettyXHTMLString() throws {
    let indent = String.Indent.spaces(count: 2)
    let comment = try Comment("line0\r\nline1\r\n")
    XCTAssertEqual(comment.prettyXHTMLString(indent: indent),
                   "<!--\n\(indent)line0\n\(indent)line1\n-->\n")
    
    let comment_oneLine = try Comment("one line")
    XCTAssertEqual(comment_oneLine.prettyXHTMLString(), "<!--one line-->")
    
    let comment_oneLineWithNewline = try Comment("one line\r")
    XCTAssertEqual(comment_oneLineWithNewline.prettyXHTMLString(indent: indent),
                   "<!--\n\(indent)one line\n-->\n")
  }
}



