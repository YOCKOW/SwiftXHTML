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
  public private(set) weak var parent: Element? = nil
  
  /// Set the new parent.
  /// 
  /// Note: In some subclasses, there may be necessary to validate its parent.
  internal func _setParent(_ newParent: Element?) throws {
    self.parent = newParent
  }
  
  public func isEqual(to other:Node) -> Bool { return self === other }
  public static func == (lhs: Node, rhs: Node) -> Bool {
    return lhs.isEqual(to:rhs)
  }
}

