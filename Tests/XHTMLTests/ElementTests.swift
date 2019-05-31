/* *************************************************************************************************
 ElementTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

import TestResources

final class ElementTests: XCTestCase {
  func test_xhtmlString() {
    let element = Element(name:"element")
    element.attributes = ["name":"value&value"]
    
    XCTAssertEqual(element.xhtmlString, "<element name=\"value&amp;value\" />")
  }
  
  func test_classSelector() {
    let title = Element(name:"title",
                        attributes:["xmlns":"http://www.w3.org/1999/xhtml"],
                        parent:nil)
    XCTAssertTrue(title is TitleElement)
    
    let head = Element(name: "xhtml:head", attributes: [:], xhtmlPrefix: .namespace("xhtml"))
    XCTAssertTrue(head is HeadElement)
  }
  
  func test_equatable() {
    let element1 = Element(name:"foo", attributes:["name":"value"], children:[.text("Text")])
    let element2 = Element(name:"foo", attributes:["name":"value"], children:[.text("Text")])
    XCTAssertTrue(element1 !== element2)
    XCTAssertEqual(element1, element2)
  }
  
  func test_namespace() {
    let grandchild = Element(name:"grandchild", attributes:["name":"value", "myns:name":"my value"])
    let child = Element(name:"child", attributes:["xmlns:myns":"http://my/ns"], children:[grandchild])
    let root = Element(name:"root", attributes:["xmlns":"http://default/ns"], children:[child])
    
    XCTAssertEqual(grandchild.namespace(for: .default), "http://default/ns")
    XCTAssertEqual(grandchild.namespace(for: .namespace("myns")), "http://my/ns")
    XCTAssertEqual(grandchild.prefix(for: "http://my/ns"), .namespace("myns"))
    XCTAssertEqual(grandchild.prefix(for: "http://default/ns"), .default)
    XCTAssertEqual(grandchild.prefix(for: "http://invalid/ns"), nil)
    
    XCTAssertEqual(child.namespace(for: .default), "http://default/ns")
    XCTAssertEqual(child.namespace(for: .namespace("myns")), "http://my/ns")
    XCTAssertEqual(child.prefix(for: "http://my/ns"), .namespace("myns"))
    XCTAssertEqual(child.prefix(for: "http://default/ns"), .default)
    XCTAssertEqual(child.prefix(for:"http://invalid/ns"), nil)
    
    XCTAssertEqual(root.namespace(for: .default), "http://default/ns")
    XCTAssertEqual(root.namespace(for: .namespace("myns")), nil)
    XCTAssertEqual(root.prefix(for: "http://my/ns"), nil)
    XCTAssertEqual(root.prefix(for: "http://default/ns"), .default)
    XCTAssertEqual(root.prefix(for: "http://invalid/ns"), nil)
    
    XCTAssertEqual(grandchild.attributes[localName:"name", uri:nil], "value")
    XCTAssertEqual(grandchild.attributes[localName:"name", uri:"http://default/ns"], "value")
    XCTAssertEqual(grandchild.attributes[localName:"name", uri:"http://my/ns"], "my value")
    
    grandchild.attributes[localName:"name", uri:"http://my/ns"] = "another value"
    XCTAssertEqual(grandchild.attributes[localName:"name", uri:"http://my/ns"], "another value")

    child.attributes[localName:"name", uri:"http://my/ns"] = "child value"
    XCTAssertEqual(child.attributes["myns:name"], "child value")
  }
  
  func test_globalAttributes() {
    let html = HTMLElement(name:"xhtml:html", attributes:["xmlns:xhtml":._xhtmlNamespace])
    let element = Element(name:"xhtml:element")
    html.append(element)
    
    element.attributes["accesskey"] = "k"
    XCTAssertEqual(element.globalAttributes.accessKey, "k")
    element.globalAttributes.accessKey = "a"
    XCTAssertEqual(element.attributes["accesskey"], "a")
    
    element.attributes["class"] = "class1 class2"
    XCTAssertEqual(element.globalAttributes.class, ["class1", "class2"])
    element.globalAttributes.class = ["anotherClass1", "anotherClass2"]
    XCTAssertEqual(element.attributes["class"], "anotherClass1 anotherClass2")
    
    element.attributes["contenteditable"] = "inherit"
    XCTAssertEqual(element.globalAttributes.contentEditable, nil)
    element.globalAttributes.contentEditable = true
    XCTAssertEqual(element.attributes["contenteditable"], "true")
    
    element.attributes["dir"] = "auto"
    XCTAssertEqual(element.globalAttributes.direction, .auto)
    element.globalAttributes.direction = .leftToRight
    XCTAssertEqual(element.attributes["dir"], "ltr")
    
    element.attributes["dropzone"] = "link"
    XCTAssertEqual(element.globalAttributes.dropZone, .link)
    element.globalAttributes.dropZone = .copy
    XCTAssertEqual(element.attributes["dropzone"], "copy")
    
    element.attributes["hidden"] = "hidden"
    XCTAssertEqual(element.globalAttributes.hidden, true)
    element.globalAttributes.hidden = false
    XCTAssertEqual(element.attributes["hidden"], nil)
    
    element.attributes["id"] = "id1"
    XCTAssertEqual(element.globalAttributes.identifier, "id1")
    element.globalAttributes.identifier = "id2"
    XCTAssertEqual(element.attributes["id"], "id2")
    
    element.attributes["lang"] = "ja"
    XCTAssertEqual(element.globalAttributes.language, "ja")
    element.globalAttributes.language = "en"
    XCTAssertEqual(element.attributes["lang"], "en")
    
    element.attributes["spellcheck"] = "false"
    XCTAssertEqual(element.globalAttributes.spellCheck, false)
    element.globalAttributes.spellCheck = true
    XCTAssertEqual(element.attributes["spellcheck"], "true")
    
    element.attributes["style"] = "color:green;"
    XCTAssertEqual(element.globalAttributes.style, "color:green;")
    element.globalAttributes.style = "color:blue;"
    XCTAssertEqual(element.attributes["style"], "color:blue;")
    
    element.attributes["tabindex"] = "1"
    XCTAssertEqual(element.globalAttributes.tabIndex, 1)
    element.globalAttributes.tabIndex = 100
    XCTAssertEqual(element.attributes["tabindex"], "100")
    
    element.attributes["title"] = "title1"
    XCTAssertEqual(element.globalAttributes.title, "title1")
    element.globalAttributes.title = "title2"
    XCTAssertEqual(element.attributes["title"], "title2")
    
    element.attributes["translate"] = "no"
    XCTAssertEqual(element.globalAttributes.translate, false)
    element.globalAttributes.translate = true
    XCTAssertEqual(element.attributes["translate"], "yes")
    
    element.attributes["data-abc-def"] = "some data"
    XCTAssertEqual(element.globalAttributes.dataSet["abcDef"], "some data")
    element.globalAttributes.dataSet["abcDef"] = "another data"
    XCTAssertEqual(element.attributes["data-abc-def"], "another data")
  }
  
  func test_id() {
    let document =
      try! Parser.parse(TestResources.shared.data(for:"XHTML/XHTML5ForVariousTests.xhtml")!)
    
    let element = document.element(for:"My ID")
    XCTAssertNotNil(element)
    
    guard case let text as Text = element?.children.first else {
      XCTFail("Unexpected element.")
      return
    }
    XCTAssertEqual(text.text, "The identifier of this element is \"My ID\"")
  }
  
  func test_prettyXHTMLString() {
    let parent = Element(name:"parent")
    XCTAssertEqual(parent.prettyXHTMLString, "<parent />")
    
    let child = Element(name:"child")
    parent.append(child)
    XCTAssertEqual(parent.prettyXHTMLString, "<parent><child /></parent>")
    
    let grandchild = Element(name:"grandchild")
    child.append(grandchild)
    XCTAssertEqual(parent.prettyXHTMLString, "<parent><child><grandchild /></child></parent>")
    
    let grandchild2 = Element(name:"grandchild2")
    child.append(grandchild2)
    
    XCTAssertEqual(child.prettyXHTMLString, """
      <child>
      \(_indent)<grandchild />
      \(_indent)<grandchild2 />
      </child>
      """
    )
    
    XCTAssertEqual(parent.prettyXHTMLString, """
      <parent>
      \(_indent)<child>
      \(_indent)\(_indent)<grandchild />
      \(_indent)\(_indent)<grandchild2 />
      \(_indent)</child>
      </parent>
      """
    )
  }
}




