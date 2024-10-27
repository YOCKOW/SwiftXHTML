/* *************************************************************************************************
 ParserTests.swift
   © 2019,2024 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import TestResources
@testable import XHTML

#if swift(>=6) && canImport(Testing)
import Testing

@Suite final class ParserTests {
  @Test func test_parseSimpleXHTML5() throws {
    let document = try Parser.parse(try #require(TestResources.shared.data(for:"XHTML/SimpleXHTML5.utf8.xhtml")))
    #expect(document.title == "XHTML5")
  }

  @Test func test_errors_document() {
    func _test_localFile<E>(at relativePath: String, expectedError: E, sourceLocation: SourceLocation = #_sourceLocation) where E: Error {
      do {
        let _ = try Parser.parse(TestResources.shared.data(for:"XHTML/InvalidXHTML/" + relativePath)!)
        Issue.record("No error was thrown.", sourceLocation: sourceLocation)
      } catch {
        switch (error, expectedError) {
        case (let parserError as Parser.Error, let expectedError as Parser.Error):
          #expect(parserError == expectedError, sourceLocation: sourceLocation)
        case (let elementError as ElementError, let expectedError as ElementError):
          #expect(elementError == expectedError, sourceLocation: sourceLocation)
        default:
          Issue.record("Unexpected Error: \(error.localizedDescription)", sourceLocation: sourceLocation)
          return
        }
      }
    }

    _test_localFile(at: "RootElementIsNotHTML.xhtml", expectedError: Parser.Error.rootElementIsNotHTML)
  }

  @Test func test_element() throws {
    let element = try Element(xhtmlString: """
    <div id="Outer">
      <span id="Inner">Some Text</span>
    </div>
    """)

    #expect(element is DivisionElement)
    #expect(element.attributes["id"] == "Outer")
    #expect(element.children.count == 1)
    #expect(element.children.first is SpanElement)
  }

  @Test func test_pre() throws {
    let string = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>Title</title>
      </head>
      <body>
        <div>
          Here is my code:
    <pre>
    <span class="keyword">if</span> <span class="keyword">let</span> string = maybeString {
      print(string)
    }
    </pre>
        </div>
      </body>
    </html>
    """
    let document = try Parser.parse(#require(string.data(using: .utf8)))
    let parsedString = document.rootElement.xhtmlString
    #expect(
      parsedString ==
      #"<html xmlns="http://www.w3.org/1999/xhtml"><head><title>Title</title></head><body><div>Here is my code:<pre><span class="keyword">if</span>&#x20;<span class="keyword">let</span>&#x20;string = maybeString {&#x0A;  print(string)&#x0A;}</pre></div></body></html>"#
    )
  }

  @Test func test_pre_element() throws {
    let pre = try PreformattedTextElement(xhtmlString: """
    <pre>
    <span class="keyword">if</span> <span class="keyword">let</span> string = maybeString {
      print(string)
    }
    </pre>
    """)

    #expect(
      pre.xhtmlString ==
      #"<pre><span class="keyword">if</span>&#x20;<span class="keyword">let</span>&#x20;string = maybeString {&#x0A;  print(string)&#x0A;}</pre>"#
    )
  }
}
#else
import XCTest

final class ParserTests: XCTestCase {
  func test_parseSimpleXHTML5() throws {
    let document = try Parser.parse(try XCTUnwrap(TestResources.shared.data(for:"XHTML/SimpleXHTML5.utf8.xhtml")))
    XCTAssertEqual(document.title, "XHTML5")
  }
  
  func test_errors_document() {
    func _test_localFile<E>(at relativePath: String, expectedError: E, file: StaticString = #filePath, line: UInt = #line) where E: Error {
      do {
        let _ = try Parser.parse(TestResources.shared.data(for:"XHTML/InvalidXHTML/" + relativePath)!)
        XCTFail("No error was thrown.", file: file, line: line)
      } catch {
        switch (error, expectedError) {
        case (let parserError as Parser.Error, let expectedError as Parser.Error):
          XCTAssertEqual(parserError, expectedError, file: file, line: line)
        case (let elementError as ElementError, let expectedError as ElementError):
          XCTAssertEqual(elementError, expectedError, file: file, line: line)
        default:
          XCTFail("Unexpected Error: \(error.localizedDescription)", file:file, line:line)
          return
        }
      }
    }
    
    _test_localFile(at: "RootElementIsNotHTML.xhtml", expectedError: Parser.Error.rootElementIsNotHTML)
  }
  
  func test_element() throws {
    let element = try Element(xhtmlString: """
    <div id="Outer">
      <span id="Inner">Some Text</span>
    </div>
    """)
    
    XCTAssertTrue(element is DivisionElement)
    XCTAssertEqual(element.attributes["id"], "Outer")
    XCTAssertEqual(element.children.count, 1)
    XCTAssertTrue(element.children.first is SpanElement)
  }
  
  func test_pre() throws {
    let string = """
    <?xml version="1.0" encoding="UTF-8"?>
    <!DOCTYPE html>
    <html xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>Title</title>
      </head>
      <body>
        <div>
          Here is my code:
    <pre>
    <span class="keyword">if</span> <span class="keyword">let</span> string = maybeString {
      print(string)
    }
    </pre>
        </div>
      </body>
    </html>
    """
    let document = try Parser.parse(XCTUnwrap(string.data(using: .utf8)))
    let parsedString = document.rootElement.xhtmlString
    XCTAssertEqual(
      parsedString,
      #"<html xmlns="http://www.w3.org/1999/xhtml"><head><title>Title</title></head><body><div>Here is my code:<pre><span class="keyword">if</span>&#x20;<span class="keyword">let</span>&#x20;string = maybeString {&#x0A;  print(string)&#x0A;}</pre></div></body></html>"#
    )
  }
  
  func test_pre_element() throws {
    let pre = try PreformattedTextElement(xhtmlString: """
    <pre>
    <span class="keyword">if</span> <span class="keyword">let</span> string = maybeString {
      print(string)
    }
    </pre>
    """)
    
    XCTAssertEqual(
      pre.xhtmlString,
      #"<pre><span class="keyword">if</span>&#x20;<span class="keyword">let</span>&#x20;string = maybeString {&#x0A;  print(string)&#x0A;}</pre>"#
    )
  }
}
#endif
