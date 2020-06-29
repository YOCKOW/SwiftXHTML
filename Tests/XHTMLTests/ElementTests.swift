/* *************************************************************************************************
 ElementTests.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import XCTest
@testable import XHTML

import StringComposition
import TestResources

final class ElementTests: XCTestCase {
  func test_xhtmlString() throws {
    let element = try Element(name:"element")
    element.attributes = ["name":"value&value"]
    
    XCTAssertEqual(element.xhtmlString, "<element name=\"value&amp;value\" />")
  }
  
  func test_classSelector() throws {
    let title = try Element(_name:"title",
                            attributes: ["xmlns":"http://www.w3.org/1999/xhtml"],
                            parent: nil)
    XCTAssertTrue(title is TitleElement)
    
    let head = try Element(_name: "xhtml:head", attributes: [:], xhtmlPrefix: .namespace("xhtml"))
    XCTAssertTrue(head is HeadElement)
  }
  
  func test_equatable() throws {
    let element1 = try Element(name:"foo", attributes: ["name":"value"], children: [.text("Text")])
    let element2 = try Element(name:"foo", attributes: ["name":"value"], children: [.text("Text")])
    XCTAssertTrue(element1 !== element2)
    XCTAssertEqual(element1, element2)
  }
  
  func test_namespace() throws {
    let grandchild = try Element(name: "grandchild", attributes: ["name":"value", "myns:name":"my value"])
    let child = try Element(name: "child", attributes: ["xmlns:myns":"http://my/ns"], children: [grandchild])
    let root = try Element(name: "root", attributes: ["xmlns":"http://default/ns"], children: [child])
    
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
  
  func test_globalAttributes() throws {
    let html = try HTMLElement(name: "xhtml:html", attributes: ["xmlns:xhtml":._xhtmlNamespace])
    let element = try Element(name: "xhtml:element")
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
    XCTAssertEqual(element.globalAttributes.dataSet.abcDef, "some data")
    element.globalAttributes.dataSet.abcDef = "another data"
    XCTAssertEqual(element.attributes["data-abc-def"], "another data")
  }
  
  func test_id() throws {
    let document = try Parser.parse(TestResources.shared.data(for:"XHTML/XHTML5ForVariousTests.xhtml")!)
    
    let element = document.element(for:"My ID")
    XCTAssertNotNil(element)
    
    guard case let text as Text = element?.children.first else {
      XCTFail("Unexpected element.")
      return
    }
    XCTAssertEqual(text.text, "The identifier of this element is \"My ID\"")
  }
  
  func test_prettyXHTMLString() throws {
    let indent = String.Indent.spaces(count: 2)
    
    let parent = try Element(name: "parent")
    XCTAssertEqual(parent.prettyXHTMLString(indent: indent), "<parent />\n")
    
    let child = try Element(name: "child")
    parent.append(child)
    XCTAssertEqual(parent.prettyXHTMLString(indent: indent), "<parent><child /></parent>\n")
    
    let grandchild = try Element(name: "grandchild")
    child.append(grandchild)
    XCTAssertEqual(parent.prettyXHTMLString(indent: indent), "<parent><child><grandchild /></child></parent>\n")
    
    let grandchild2 = try Element(name: "grandchild2")
    child.append(grandchild2)
    
    XCTAssertEqual(child.prettyXHTMLString(indent: indent), """
      <child>
      \(indent)<grandchild />
      \(indent)<grandchild2 />
      </child>
      
      """
    )
    
    XCTAssertEqual(parent.prettyXHTMLString(indent: indent), """
      <parent>
      \(indent)<child>
      \(indent)\(indent)<grandchild />
      \(indent)\(indent)<grandchild2 />
      \(indent)</child>
      </parent>
      
      """
    )
  }
  
  func test_simpleTextContent() throws {
    let title = try TitleElement(xhtmlPrefix: .none, text: "Title")
    XCTAssertEqual(title.title, "Title")
  }
  
  func test_headingElements() {
    let headings: [Node] = [
      .h1(text:"h1"),
      .h2(text:"h2"),
      .h3(text:"h3"),
      .h4(text:"h4"),
      .h5(text:"h5"),
      .h6(text:"h6"),
    ]
    
    for ii in 0..<6 {
      let heading = headings[ii] as? Element
      XCTAssertEqual(heading?.name, QualifiedName("h\(ii + 1)"))
      XCTAssertEqual(heading?.children.count, 1)
      XCTAssertEqual((heading?.children.first as? Text)?.text, "h\(ii + 1)")
    }
  }
  
  func test_abbr() throws {
    let abbr = try AbbreviationElement(fullForm: "HyperText Markup Language", abbreviation: "HTML")
    XCTAssertEqual(abbr.xhtmlString, #"<abbr title="HyperText Markup Language">HTML</abbr>"#)
  }
  
  func test_base() throws {
    let base = try BaseElement(hypertextReference: "https://example.com/", target: .top)
    XCTAssertEqual(base.xhtmlString, #"<base href="https://example.com/" target="_top" />"#)
  }
  
  func test_data() throws {
    let data = try DataElement(value: "1", text: "壱")
    XCTAssertEqual(data.xhtmlString, #"<data value="1">壱</data>"#)
  }
  
  func test_datalist() throws {
    let datalist = try DataListElement(identifier: "candidates", values: ["A", "B"])
    XCTAssertEqual(datalist.xhtmlString, #"<datalist id="candidates"><option value="A"></option><option value="B"></option></datalist>"#)
  }
  
  func test_html() throws {
    let html = try HTMLElement(name: "html")
    XCTAssertEqual(html.attributes[.namespaceDeclaration(.none)], String._xhtmlNamespace)
  }
  
  func test_ruby() throws {
    let ruby = try XCTUnwrap(Node.ruby(text: "明日", rubyText: "あした") as? RubyElement)
    XCTAssertEqual(ruby.xhtmlString, "<ruby>明日<rt>あした</rt></ruby>")
    
    let rubyWithParenthesis = try XCTUnwrap(Node.ruby(text: "明日", rubyText: "あした", includesFallbackParenthesis: true) as? RubyElement)
    XCTAssertEqual(rubyWithParenthesis.xhtmlString, "<ruby>明日<rp>(</rp><rt>あした</rt><rp>)</rp></ruby>")
  }
  
  func test_selection() throws {
    do {
      let select = try SelectionElement(options: [
        try .init(value: "A", text: "A"),
        try .init(value: "B", text: "B"),
        try .init(value: "C", text: "C"),
      ])
      
      XCTAssertEqual(select.prettyXHTMLString(indent: .spaces(count: 2)), """
      <select>
        <option value="A">A</option>
        <option value="B">B</option>
        <option value="C">C</option>
      </select>
      
      """)
    }
    
    do { // optgroup
      let select = try SelectionElement(optionGroups: [
        try .init(label: "Group 1", options: [
          try .init(value: "1-A", label: "1-A"),
          try .init(value: "1-B", label: "1-B"),
          try .init(value: "1-C", label: "1-C"),
        ]),
        try .init(label: "Group 2", options: [
          try .init(value: "2-A", label: "2-A"),
          try .init(value: "2-B", label: "2-B"),
          try .init(value: "2-C", label: "2-C"),
        ]),
      ])
      
      XCTAssertEqual(select.prettyXHTMLString(indent: .spaces(count: 2)), """
      <select>
        <optgroup label="Group 1">
          <option label="1-A" value="1-A"></option>
          <option label="1-B" value="1-B"></option>
          <option label="1-C" value="1-C"></option>
        </optgroup>
        <optgroup label="Group 2">
          <option label="2-A" value="2-A"></option>
          <option label="2-B" value="2-B"></option>
          <option label="2-C" value="2-C"></option>
        </optgroup>
      </select>
      
      """)
    }
  }
  
  func test_style() throws {
    let style = try StyleElement(css: """
    #ID {
      font-size: 1000%;
    }
    """)
    XCTAssertEqual(style.xhtmlString, """
    <style type="text/css"><![CDATA[
    #ID {
      font-size: 1000%;
    }
    ]]></style>
    """)
  }
  
  func test_table() throws {
    let table = try TableElement(caption: [.text("CAPTION")],
                                 numberOfHeaderRows: 1,
                                 numberOfHeaderColumns: 1,
                                 numberOfRows: 2,
                                 numberOfColumns: 1,
                                 numberOfFooterRows: 1)
    
    table.header?[0][0].append(.text("NAME"))
    table.header?[0][1].append(.text("AGE"))
    
    table.body?[0][0].append(.text("桃太郎"))
    table.body?[0][1].append(.text("18"))
    
    table.body?[1][0].append(.text("金太郎"))
    table.body?[1][1].append(.text("20"))
    
    table.footer?[0][0].append(.text("平均"))
    table.footer?[0][1].append(.text("19"))
    
    XCTAssertEqual(
      table.xhtmlString,
      "<table><caption>CAPTION</caption>" +
      #"<thead><tr><th scope="row">NAME</th><th scope="col">AGE</th></tr></thead>"# +
      #"<tbody><tr><th scope="row">桃太郎</th><td>18</td></tr><tr><th scope="row">金太郎</th><td>20</td></tr></tbody>"# +
      #"<tfoot><tr><th scope="row">平均</th><td>19</td></tr></tfoot>"# +
      "</table>"
    )
  }
  
  func test_table_calendar() {
    let calendar = TableElement.calendar(year: 2020, month: 6, locale: .init(identifier: "en_US"))
    
    XCTAssertEqual(
      calendar.prettyXHTMLString(indent: .spaces(count: 2), newline: .lineFeed),
      """
      <table class="calendar">
        <thead class="calendar_weekdayNames">
          <tr>
            <th class="calendar_weekdayName_0">Sun</th>
            <th class="calendar_weekdayName_1">Mon</th>
            <th class="calendar_weekdayName_2">Tue</th>
            <th class="calendar_weekdayName_3">Wed</th>
            <th class="calendar_weekdayName_4">Thu</th>
            <th class="calendar_weekdayName_5">Fri</th>
            <th class="calendar_weekdayName_6">Sat</th>
          </tr>
        </thead>
        <tbody class="calendar_body">
          <tr>
            <td class="calendar_weekday_0"></td>
            <td class="calendar_weekday_1">1</td>
            <td class="calendar_weekday_2">2</td>
            <td class="calendar_weekday_3">3</td>
            <td class="calendar_weekday_4">4</td>
            <td class="calendar_weekday_5">5</td>
            <td class="calendar_weekday_6">6</td>
          </tr>
          <tr>
            <td class="calendar_weekday_0">7</td>
            <td class="calendar_weekday_1">8</td>
            <td class="calendar_weekday_2">9</td>
            <td class="calendar_weekday_3">10</td>
            <td class="calendar_weekday_4">11</td>
            <td class="calendar_weekday_5">12</td>
            <td class="calendar_weekday_6">13</td>
          </tr>
          <tr>
            <td class="calendar_weekday_0">14</td>
            <td class="calendar_weekday_1">15</td>
            <td class="calendar_weekday_2">16</td>
            <td class="calendar_weekday_3">17</td>
            <td class="calendar_weekday_4">18</td>
            <td class="calendar_weekday_5">19</td>
            <td class="calendar_weekday_6">20</td>
          </tr>
          <tr>
            <td class="calendar_weekday_0">21</td>
            <td class="calendar_weekday_1">22</td>
            <td class="calendar_weekday_2">23</td>
            <td class="calendar_weekday_3">24</td>
            <td class="calendar_weekday_4">25</td>
            <td class="calendar_weekday_5">26</td>
            <td class="calendar_weekday_6">27</td>
          </tr>
          <tr>
            <td class="calendar_weekday_0">28</td>
            <td class="calendar_weekday_1">29</td>
            <td class="calendar_weekday_2">30</td>
            <td class="calendar_weekday_3"></td>
            <td class="calendar_weekday_4"></td>
            <td class="calendar_weekday_5"></td>
            <td class="calendar_weekday_6"></td>
          </tr>
        </tbody>
      </table>
      
      """
    )
  }
}
