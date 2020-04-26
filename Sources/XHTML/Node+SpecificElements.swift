/* *************************************************************************************************
 Node+SpecificElements.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
extension Node {
  /// Create an \<a\> element.
  public static func a(xhtmlPrefix: QualifiedName.Prefix = .none, href:String, text:String, attributes:Attributes = [:]) -> Node {
    return try! AnchorElement(xhtmlPrefix: xhtmlPrefix, hypertextReference: href, text: text, attributes: attributes)
  }
  
  /// Create an \<abbr>\</abbr> element.
  public static func abbr(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! AbbreviationElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func abbr(xhtmlPrefix: QualifiedName.Prefix = .none, fullForm: String? = nil, abbreviation: String) -> Node {
    return try! AbbreviationElement(xhtmlPrefix: xhtmlPrefix, fullForm: fullForm, abbreviation: abbreviation)
  }
  
  public static func abbr(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! AbbreviationElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<address>\</address> element.
  public static func address(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! AddressElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<area /> element.
  public static func area(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:]) -> Node {
    return try! ImageAreaElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create an \<article>\</article> element.
  public static func article(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! ArticleElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<aside>\</aside> element.
  public static func aside(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! AsideElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<audio>\</audio> element.
  public static func audio(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! AudioElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<bdi>\</bdi> element.
  public static func bdi(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children: [Node] = []) -> Node {
    return try! BidirectionalIsolateElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func bdi(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! BidirectionalIsolateElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<bdo>\</bdo> element.
  public static func bdo(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children: [Node] = []) -> Node {
    return try! BidirectionalTextOverrideElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func bdo(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! BidirectionalTextOverrideElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<blockquote>\</blockquote> element.
  public static func blockquote(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! BlockQuoteElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<body\> element.
  public static func body(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children:[Node] = []) -> Node {
    return try! BodyElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  /// Create a \<br /> element.
  public static func br(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:]) -> Node {
    return try! LineBreakElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create a \<button>\</button> element.
  public static func button(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:]) -> Node {
    return try! ButtonElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create a \<canvas>\</canvas> element.
  public static func canvas(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! CanvasElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<caption> element.
  public static func caption(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TableCaptionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func caption(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! TableCaptionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<cite>\</cite> element.
  public static func cite(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! CitationElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func cite(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! CitationElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<code>\</code> element.
  public static func code(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! CodeElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func code(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! CodeElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an XHTML comment node.
  /// Fatal error will occur if `text` is invalid for XML comment.
  public static func comment(_ text:String) throws -> Node {
    return try Comment(text)
  }
  
  /// Create a \<data>\</data> element.
  public static func data(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DataElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<data value=\"`value`\">`text`\</data> element.
  public static func data(xhtmlPrefix: QualifiedName.Prefix = .none, value: String, text: String) -> Node {
    return try! DataElement(xhtmlPrefix: xhtmlPrefix, value: value, text: text)
  }
  
  /// Create a \<datalist>\</datalist> element.
  public static func datalist(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DataListElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<del>\</del> element.
  public static func del(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DeletionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<details>\</details> element.
  public static func details(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DetailsElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<dd>\</dd> node.
  public static func dd(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DescriptionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func dd(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! DescriptionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<dfn>\</dfn> node.
  public static func dfn(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DefinitionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func dfn(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! DefinitionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<div>\</div> node.
  public static func div(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DivisionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<dl>\</dl> node.
  public static func dl(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DescriptionListElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<dt>\</dt> node.
  public static func dt(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DescriptionTermElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func dt(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! DescriptionTermElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<em>\</em> node.
  public static func em(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! EmphasisElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  public static func em(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! EmphasisElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<embed>\</embed> node.
  public static func embed(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! EmbeddedElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  /// Create a \<fieldset>\</fieldset> node.
  public static func fieldset(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children:[Node] = []) -> Node {
    return try! FieldSetElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  
  /// Create a \<figcaption>\</figcaption> node.
  public static func figcaption(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children:[Node] = []) -> Node {
    return try! FigureCaptionElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  public static func figcaption(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! FigureCaptionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<figure>\</figure> node.
  public static func figure(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children:[Node] = []) -> Node {
    return try! FigureElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  /// Create a \<footer>\</footer> node.
  public static func footer(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children:[Node] = []) -> Node {
    return try! FooterElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  /// Create a \<form\>\</form\> element.
  public static func form(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children:[Node] = []) -> Node {
    return try! FormElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  /// Create an \<h1> element with specifide child-nodes.
  public static func h1(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node
  {
    return try! H1Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<h1> element with specified text.
  public static func h1(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! H1Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<h2> element with specified child-nodes.
  public static func h2(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! H2Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<h2> element with specified text.
  public static func h2(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! H2Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<h3> element with specified child-nodes.
  public static func h3(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! H3Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<h3> element with specified text.
  public static func h3(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! H3Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<h4> element with specified child-nodes.
  public static func h4(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! H4Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<h4> element with specified text.
  public static func h4(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! H4Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<h5> element with specified child-nodes.
  public static func h5(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! H5Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<h5> element with specified text.
  public static func h5(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! H5Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<h6> element with specifide child-nodes.
  public static func h6(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! H6Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<h6> element with specified text.
  public static func h6(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! H6Element(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<head\> element.
  public static func head(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:], children:[Node] = []) -> Node {
    return try! HeadElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  /// Create a \<header>\</header> element.
  public static func header(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node]) -> Node {
    return try! HeaderElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<html\> element.
  public static func html(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! HTMLElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes, children:children)
  }
  
  /// Create a \<hr /> element.
  public static func hr(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:]) -> Node {
    return try! HorizontalRuleElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create an \<iframe>\</iframe> element.
  public static func iframe(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! InlineFrameElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create an \<image /> element.
  public static func image(xhtmlPrefix: QualifiedName.Prefix = .none, attributes:Attributes = [:]) -> Node {
    return try! ImageElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create an \<input\> element.
  public static func input(xhtmlPrefix: QualifiedName.Prefix = .none,
                           type:InputElement.TypeValue,
                           nameAttribute: String? = nil, value: String? = nil,
                           attributes: Attributes = [:]) -> Node {
    return try! InputElement(xhtmlPrefix: xhtmlPrefix,
                        type:type, nameAttribute:nameAttribute, value:value,
                        attributes:attributes)
  }
  
  /// Create an \<ins>\</ins> element.
  public static func ins(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! InsertionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<kbd\>\</kbd\> element.
  public static func kbd(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! KeyboardInputElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func kbd(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! KeyboardInputElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<label\>\</label\> element.
  public static func label(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! LabelElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<legend\>\</legend\> element.
  public static func legend(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! LegendElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func legend(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! LegendElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<li\>\</li\> element.
  public static func li(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! ListItemElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<main\>\</main\> element.
  public static func main(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! MainElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<map>\</map> element.
  public static func map(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! ImageMapElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create a \<mark\>\</mark\> element.
  public static func mark(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! MarkTextElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func mark(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! MarkTextElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<meter\>\</meter\> element.
  public static func meter(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! MeterElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<nav\>\</nav\> element.
  public static func nav(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! NavigationElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<noscript\>\</noscript\> element.
  public static func noscript(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! NoScriptElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<object\>\</object\> element.
  public static func object(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! ObjectElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<ol\>\</ol\> element.
  public static func ol(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! OrderedListElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<optgroup\>\</optgroup\> element.
  public static func optgroup(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! OptionGroupElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func optgroup<S>(xhtmlPrefix: QualifiedName.Prefix = .none, label: String, options: S) -> Node where S: Sequence, S.Element: OptionElement {
    return try! OptionGroupElement(xhtmlPrefix: xhtmlPrefix, label: label, options: options)
  }
  
  /// Create an \<option\>\</option\> element.
  public static func option(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! OptionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func option(xhtmlPrefix: QualifiedName.Prefix = .none, value: String, text: String, isSelected: Bool = false) -> Node {
    return try! OptionElement(xhtmlPrefix: xhtmlPrefix, value: value, text: text, isSelected: isSelected)
  }
  
  /// Create an \<output\>\</output\> element.
  public static func output(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! OutputElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<p\>\</p\> element.
  public static func p(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! ParagraphElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<param /> element.
  public static func param(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:]) -> Node {
    return try! ParameterElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create a \<picture\>\</picture\> element.
  public static func picture(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! PictureElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<pre\>\</pre\> element.
  public static func pre(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! PreformattedTextElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<progress\>\</progress\> element.
  public static func progress(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! ProgressIndicatorElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<q\>\</q\> element.
  public static func q(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! QuotationElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func q(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! QuotationElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<ruby\>\</ruby\> element.
  public static func ruby(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! RubyElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<ruby\> element with its texts.
  public static func ruby(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:],
                          text: String, rubyText: String, includesFallbackParenthesis: Bool = false) -> Node {
    return try! RubyElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes,
                       text: text, rubyText: rubyText, includesFallbackParenthesis: includesFallbackParenthesis)
  }
  
  /// Create an \<rp\>\</rp\> element.
  public static func rp(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! RubyFallbackParenthesisTextElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<rt\>\</rt\> element.
  public static func rt(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! RubyTextElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func rt(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! RubyTextElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create an \<rtc\>\</rtc\> element.
  public static func rtc(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! RubyTextContainerElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<samp\>\</samp\> element.
  public static func samp(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! SampleElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func samp(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! SampleElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<script\>\</script\> element.
  public static func script(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! ScriptElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<select\>\</select\> element.
  public static func select(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! SelectionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func select<S>(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], options: S) -> Node where S: Sequence, S.Element: OptionElement {
    return try! SelectionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, options: options)
  }
  
  public static func select<S>(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], optionGroups: S) -> Node where S: Sequence, S.Element: OptionGroupElement {
    return try! SelectionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, optionGroups: optionGroups)
  }
  
  /// Create a \<section\>\</section\> element.
  public static func section(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! SectionElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<small\>\</small\> element.
  public static func small(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! SmallElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func small(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! SmallElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<span\>\</span\> element.
  public static func span(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! SpanElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<s\>\</s\> element.
  public static func s(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! StrikedElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func s(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! StrikedElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<source /\> element.
  public static func source(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:]) -> Node {
    return try! MediaSourceElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
  
  /// Create a \<strong\>\</strong\> element.
  public static func strong(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! StrongElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func strong(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! StrongElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<sub\>\</sub\> element.
  public static func sub(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! SubscriptElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func sub(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! SubscriptElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<summary\>\</summary\> element.
  public static func summary(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! DisclosureSummaryElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func summary(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! DisclosureSummaryElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<sup\>\</sup\> element.
  public static func sup(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! SuperscriptElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func sup(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! SuperscriptElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<table> element.
  public static func table(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TableElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<tbody> element.
  public static func tbody(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TableBodyElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<td> element.
  public static func td(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TableDataCellElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<template\>\</template\> element.
  public static func template(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TemplateElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<time\>\</time\> element.
  public static func time(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TimeElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an XHTML text node.
  public static func text(_ text:String) -> Node {
    return Text(text)
  }
  
  /// Create a \<tfoot> element.
  public static func tfoot(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TableFooterElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<th> element.
  public static func th(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TableHeaderCellElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<thead> element.
  public static func thead(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node
  {
    return try! TableHeaderElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<title\> element.
  public static func title(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], _ title: String) -> Node {
    let titleElement = try! TitleElement(xhtmlPrefix: xhtmlPrefix, attributes:attributes)
    titleElement.title = title
    return titleElement
  }
  
  /// Create a \<tr> element.
  public static func tr(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TableRowElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<track>\</track> element.
  public static func track(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! TextTrackElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create an \<ul\>\</ul\> element.
  public static func ul(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! UnorderedListElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<var\>\</var\> element.
  public static func `var`(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! VariableElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  public static func `var`(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) -> Node {
    return try! VariableElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, text: text)
  }
  
  /// Create a \<video\>\</video\> element.
  public static func video(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], children: [Node] = []) -> Node {
    return try! VideoElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes, children: children)
  }
  
  /// Create a \<wbr /\> element.
  public static func wbr(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:]) -> Node {
    return try! WordBreakElement(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
  }
}

