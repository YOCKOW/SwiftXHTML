/* *************************************************************************************************
 Node.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

/// The nodes in the abstract, logical tree structure
/// that represents an XHTML document like `XMLNode`.
open class Node: Equatable {
  /// The string representation as it would appear in an XHTML document.
  open var xhtmlString: String { return "<!-- `var xhtmlString: String` must be overridden. -->" }
  
  /// An instance of `StringLines` (a.k.a. `String.Composition`) that represents a prettified
  /// XHTML String.
  /// This property is expected to be overridden by subclasses.
  open var prettyXHTMLLines: StringLines {
    return .init("<!-- `var prettyXHTMLLines: StringLines` must be overridden. -->", detectIndent: false)
  }
  
  
  /// Returns prettified XHTML String.
  ///
  /// This method cannot be overridden, therefore you have to override `var prettyXHTMLLines: StringLines { get }`.
  public final func prettyXHTMLString(indent: String.Indent = .default,
                                      newline: Character.Newline = .lineFeed) -> String {
    return self.prettyXHTMLLines._description(indent: indent, newline: newline)
  }
  
  /// The parent node.
  public internal(set) var parent: Element? = nil
  
  public func isEqual(to other:Node) -> Bool { return self === other }
  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.isEqual(to:rhs)
  }
}

// MARK: - Specific elements

extension Node {
  /// Create an \<a\> element.
  public static func a(name:QualifiedName = "a",
                       href:String, text:String,
                       attributes:Attributes = [:]) -> Node
  {
    return AnchorElement(name: name, hypertextReference: href, text: text, attributes: attributes)
  }
  
  /// Create an \<abbr>\</abbr> element.
  public static func abbr(name: QualifiedName = "abbr", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return AbbreviationElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<address>\</address> element.
  public static func address(name: QualifiedName = "address", attributes: Attributes = [:], children: [Node]) -> Node {
    return AddressElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<article>\</article> element.
  public static func article(name: QualifiedName = "article", attributes: Attributes = [:], children: [Node]) -> Node {
    return ArticleElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<aside>\</aside> element.
  public static func aside(name: QualifiedName = "aside", attributes: Attributes = [:], children: [Node]) -> Node {
    return AsideElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<bdi>\</bdi> element.
  public static func bdi(name:QualifiedName = "bdi", attributes:Attributes = [:], children: [Node] = []) -> Node {
    return BidirectionalIsolateElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<bdo>\</bdo> element.
  public static func bdo(name:QualifiedName = "bdo", attributes:Attributes = [:], children: [Node] = []) -> Node {
    return BidirectionalTextOverrideElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<blockquote>\</blockquote> element.
  public static func blockquote(name: QualifiedName = "blockquote", attributes: Attributes = [:], children: [Node]) -> Node {
    return BlockQuoteElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<body\> element.
  public static func body(name:QualifiedName = "body",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return BodyElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create a \<br /> element.
  public static func br(name:QualifiedName = "br", attributes:Attributes = [:]) -> Node {
    return LineBreakElement(name: name, attributes: attributes)
  }
  
  /// Create a \<caption> element.
  public static func caption(name: QualifiedName = "caption",
                             attributes: Attributes = [:],
                             children: [Node] = []) -> Node
  {
    return TableCaptionElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<cite>\</cite> element.
  public static func cite(name: QualifiedName = "cite", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return CitationElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<code>\</code> element.
  public static func code(name: QualifiedName = "code", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return CodeElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an XHTML comment node.
  /// Fatal error will occur if `text` is invalid for XML comment.
  public static func comment(_ text:String) -> Node {
    guard let comment = Comment(text) else { fatalError("Invalid text for comment.") }
    return comment
  }
  
  /// Create a \<data>\</data> element.
  public static func data(name: QualifiedName = "data", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return DataElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<del>\</del> element.
  public static func del(name: QualifiedName = "del", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return DeletionElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<dd>\</dd> node.
  public static func dd(name: QualifiedName = "dd", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return DescriptionElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<dfn>\</dfn> node.
  public static func dfn(name: QualifiedName = "dfn", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return DefinitionElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<div>\</div> node.
  public static func div(name: QualifiedName = "div", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return DivisionElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<dl>\</dl> node.
  public static func dl(name: QualifiedName = "dl", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return DescriptionListElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<dt>\</dt> node.
  public static func dt(name: QualifiedName = "dt", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return DescriptionTermElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<em>\</em> node.
  public static func em(name: QualifiedName = "em", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return EmphasisElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create a \<figcaption>\</figcaption> node.
  public static func figcaption(name:QualifiedName = "figcaption", attributes:Attributes = [:], children:[Node] = []) -> Node {
    return FigureCaptionElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create a \<figure>\</figure> node.
  public static func figure(name:QualifiedName = "figure", attributes:Attributes = [:], children:[Node] = []) -> Node {
    return FigureElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create a \<footer>\</footer> node.
  public static func footer(name:QualifiedName = "footer", attributes:Attributes = [:], children:[Node] = []) -> Node {
    return FooterElement(name:name, attributes:attributes, children:children)
  }
  
  public static func form(name:QualifiedName = "form",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return FormElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an \<h1> element with specifide child-nodes.
  public static func h1(name: QualifiedName = "h1",
                        attributes: Attributes = [:],
                        children: [Node]) -> Node
  {
    return H1Element(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<h1> element with specifide text.
  public static func h1(name: QualifiedName = "h1",
                        attributes: Attributes = [:],
                        text: String) -> Node
  {
    return h1(name: name, attributes: attributes, children: [.text(text)])
  }
  
  /// Create an \<h2> element with specifide child-nodes.
  public static func h2(name: QualifiedName = "h2",
                        attributes: Attributes = [:],
                        children: [Node]) -> Node
  {
    return H2Element(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<h2> element with specifide text.
  public static func h2(name: QualifiedName = "h2",
                        attributes: Attributes = [:],
                        text: String) -> Node
  {
    return h2(name: name, attributes: attributes, children: [.text(text)])
  }
  
  /// Create an \<h3> element with specifide child-nodes.
  public static func h3(name: QualifiedName = "h3",
                        attributes: Attributes = [:],
                        children: [Node]) -> Node
  {
    return H3Element(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<h3> element with specifide text.
  public static func h3(name: QualifiedName = "h3",
                        attributes: Attributes = [:],
                        text: String) -> Node
  {
    return h3(name: name, attributes: attributes, children: [.text(text)])
  }
  
  /// Create an \<h4> element with specifide child-nodes.
  public static func h4(name: QualifiedName = "h4",
                        attributes: Attributes = [:],
                        children: [Node]) -> Node
  {
    return H4Element(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<h4> element with specifide text.
  public static func h4(name: QualifiedName = "h4",
                        attributes: Attributes = [:],
                        text: String) -> Node
  {
    return h4(name: name, attributes: attributes, children: [.text(text)])
  }
  
  /// Create an \<h5> element with specifide child-nodes.
  public static func h5(name: QualifiedName = "h5",
                        attributes: Attributes = [:],
                        children: [Node]) -> Node
  {
    return H5Element(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<h5> element with specifide text.
  public static func h5(name: QualifiedName = "h5",
                        attributes: Attributes = [:],
                        text: String) -> Node
  {
    return h5(name: name, attributes: attributes, children: [.text(text)])
  }
  
  /// Create an \<h6> element with specifide child-nodes.
  public static func h6(name: QualifiedName = "h6",
                        attributes: Attributes = [:],
                        children: [Node]) -> Node
  {
    return H6Element(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<h6> element with specifide text.
  public static func h6(name: QualifiedName = "h6",
                        attributes: Attributes = [:],
                        text: String) -> Node
  {
    return h6(name: name, attributes: attributes, children: [.text(text)])
  }
  
  /// Create an \<head\> element.
  public static func head(name:QualifiedName = "head",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return HeadElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create an \<header>\</header> element.
  public static func header(name: QualifiedName = "header", attributes: Attributes = [:], children: [Node]) -> Node {
    return HeaderElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<html\> element.
  public static func html(name:QualifiedName = "html",
                          attributes:Attributes = [:],
                          children:[Node] = []) -> Node
  {
    return HTMLElement(name:name, attributes:attributes, children:children)
  }
  
  /// Create a \<hr /> element.
  public static func hr(name:QualifiedName = "hr", attributes:Attributes = [:]) -> Node {
    return HorizontalRuleElement(name: name, attributes: attributes)
  }
  
  /// Create an \<input\> element.
  public static func input(name:QualifiedName = "input",
                           type:InputElement.TypeValue,
                           nameAttribute:String? = nil,
                           value:String? = nil,
                           attributes:Attributes = [:]) -> Node
  {
    return InputElement(name:name,
                        type:type, nameAttribute:nameAttribute, value:value,
                        attributes:attributes)
  }
  
  /// Create a \<ins>\</ins> element.
  public static func ins(name: QualifiedName = "ins", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return InsertionElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<kbd\>\</kbd\> element.
  public static func kbd(name: QualifiedName = "kbd", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return KeyboardInputElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<li\>\</li\> element.
  public static func li(name: QualifiedName = "li", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return ListItemElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<main\>\</main\> element.
  public static func main(name: QualifiedName = "main", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return MainElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<mark\>\</mark\> element.
  public static func mark(name: QualifiedName = "mark", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return MarkTextElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<nav\>\</nav\> element.
  public static func nav(name: QualifiedName = "nav", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return NavigationElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<ol\>\</ol\> element.
  public static func ol(name: QualifiedName = "ol", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return OrderedListElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<p\>\</p\> element.
  public static func p(name: QualifiedName = "p", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return ParagraphElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<pre\>\</pre\> element.
  public static func pre(name: QualifiedName = "pre", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return PreformattedTextElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<q\>\</q\> element.
  public static func q(name: QualifiedName = "q", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return QuotationElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<ruby\>\</ruby\> element.
  public static func ruby(name: QualifiedName = "ruby", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return RubyElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<ruby\> element with its texts.
  public static func ruby(name: QualifiedName = "ruby", attributes: Attributes = [:],
                          text: String, rubyText: String, includesFallbackParenthesis: Bool = false) -> Node {
    return RubyElement(name: name, attributes: attributes,
                       text: text, rubyText: rubyText, includesFallbackParenthesis: includesFallbackParenthesis)
  }
  
  /// Create an \<rp\>\</rp\> element.
  public static func rp(name: QualifiedName = "rp", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return RubyFallbackParenthesisTextElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<rt\>\</rt\> element.
  public static func rt(name: QualifiedName = "rt", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return RubyTextElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<rtc\>\</rtc\> element.
  public static func rtc(name: QualifiedName = "rtc", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return RubyTextContainerElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<samp\>\</samp\> element.
  public static func samp(name: QualifiedName = "samp", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return SampleElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<section\>\</section\> element.
  public static func section(name: QualifiedName = "section", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return SectionElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<small\>\</small\> element.
  public static func small(name: QualifiedName = "small", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return SmallElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<span\>\</span\> element.
  public static func span(name: QualifiedName = "span", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return SpanElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<s\>\</s\> element.
  public static func s(name: QualifiedName = "s", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return StrikedElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<strong\>\</strong\> element.
  public static func strong(name: QualifiedName = "strong", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return StrongElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<sub\>\</sub\> element.
  public static func sub(name: QualifiedName = "sub", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return SubscriptElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<sup\>\</sup\> element.
  public static func sup(name: QualifiedName = "sup", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return SuperscriptElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<table> element.
  public static func table(name: QualifiedName = "table",
                           attributes: Attributes = [:],
                           children: [Node] = []) -> Node
  {
    return TableElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<tbody> element.
  public static func tbody(name: QualifiedName = "tbody",
                           attributes: Attributes = [:],
                           children: [Node] = []) -> Node
  {
    return TableBodyElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<td> element.
  public static func td(name: QualifiedName = "td",
                        attributes: Attributes = [:],
                        children: [Node] = []) -> Node
  {
    return TableDataCellElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<time\>\</time\> element.
  public static func time(name: QualifiedName = "time", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return TimeElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an XHTML text node.
  public static func text(_ text:String) -> Node {
    return Text(text)
  }
  
  /// Create an \<tfoot> element.
  public static func tfoot(name: QualifiedName = "tfoot",
                           attributes: Attributes = [:],
                           children: [Node] = []) -> Node
  {
    return TableFooterElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<th> element.
  public static func th(name: QualifiedName = "th",
                        attributes: Attributes = [:],
                        children: [Node] = []) -> Node
  {
    return TableHeaderCellElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<thead> element.
  public static func thead(name: QualifiedName = "thead",
                           attributes: Attributes = [:],
                           children: [Node] = []) -> Node
  {
    return TableHeaderElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<title\> element.
  public static func title(name:QualifiedName = "title",
                           attributes:Attributes = [:],
                           _ title: String) -> Node
  {
    let titleElement = TitleElement(name:name, attributes:attributes)
    titleElement.title = title
    return titleElement
  }
  
  /// Create an \<tr> element.
  public static func tr(name: QualifiedName = "tr",
                        attributes: Attributes = [:],
                        children: [Node] = []) -> Node
  {
    return TableRowElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create an \<ul\>\</ul\> element.
  public static func ul(name: QualifiedName = "ul", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return UnorderedListElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<var\>\</var\> element.
  public static func `var`(name: QualifiedName = "var", attributes: Attributes = [:], children: [Node] = []) -> Node {
    return VariableElement(name: name, attributes: attributes, children: children)
  }
  
  /// Create a \<wbr /\> element.
  public static func wbr(name: QualifiedName = "wbr", attributes: Attributes = [:]) -> Node {
    return WordBreakElement(name: name, attributes: attributes)
  }
}
