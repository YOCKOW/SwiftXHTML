/* *************************************************************************************************
 Node.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

internal let _indentWidth = 4
internal let _indent: String = Array<String>(repeating: " ", count: _indentWidth).joined()

/// The nodes in the abstract, logical tree structure
/// that represents an XHTML document like `XMLNode`.
open class Node: Equatable {
  /// The string representation as it would appear in an XHTML document.
  open var xhtmlString: String { return "<!-- `var xhtmlString: String` must be overridden. -->" }
  
  /// Splitted string by newline characters
  /// remaining newlines.
  internal var _prettyXHTMLStringLines: [String] { return self.xhtmlString._splittedByNewlines }
  
  /// Prettified XHTML String.
  open var prettyXHTMLString: String { return self._prettyXHTMLStringLines.joined() }
  
  /// The parent node.
  public internal(set) var parent: Element? = nil
  
  public func isEqual(to other:Node) -> Bool { return self === other }
  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.isEqual(to:rhs)
  }
}

extension Node {
  /// Create an \<a\> element.
  public static func a(name:QualifiedName = "a",
                       href:String, text:String,
                       attributes:Attributes = [:]) -> Node
  {
    return AnchorElement(name: name, hypertextReference: href, text: text, attributes: attributes)
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
  
  /// Create an XHTML comment node.
  /// Fatal error will occur if `text` is invalid for XML comment.
  public static func comment(_ text:String) -> Node {
    guard let comment = Comment(text) else { fatalError("Invalid text for comment.") }
    return comment
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
  
  /// Create an XHTML text node.
  public static func text(_ text:String) -> Node {
    return Text(text)
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
}
