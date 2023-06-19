/* *************************************************************************************************
 Node.swift
   © 2019,2021,2023 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

import StringComposition

/// The nodes in the abstract, logical tree structure
/// that represents an XHTML document like `XMLNode`.
open class Node: Equatable {
  /// The string representation as it would appear in an XHTML document.
  open var xhtmlString: String { return "<!-- `var xhtmlString: String` must be overridden. -->" }

  /// The string representation as it would appear in an HTML document.
  /// Returns `xhtmlString` in default.
  open var htmlString: String {
    get throws {
      return xhtmlString
    }
  }
  
  /// An instance of `StringLines` (a.k.a. `String.Composition`) that represents a prettified
  /// XHTML String.
  /// This property is expected to be overridden by subclasses.
  open var prettyXHTMLLines: StringLines {
    return .init("<!-- `var prettyXHTMLLines: StringLines` must be overridden. -->", detectIndent: false)
  }

  /// An instance of `StringLines` (a.k.a. `String.Composition`) that represents a prettified
  /// HTML String.
  /// This property is expected to be overridden by subclasses.
  open var prettyHTMLLines: StringLines {
    get throws {
      return prettyXHTMLLines
    }
  }

  
  /// Returns prettified XHTML String.
  ///
  /// This method cannot be overridden, therefore you have to override `var prettyXHTMLLines: StringLines { get }`.
  public final func prettyXHTMLString(indent: String.Indent = .default,
                                      newline: Character.Newline = .lineFeed) -> String {
    return self.prettyXHTMLLines._description(indent: indent, newline: newline)
  }

  /// Returns prettified HTML String.
  public final func prettyHTMLString(
    indent: String.Indent = .default,
    newline: Character.Newline = .lineFeed
  ) throws -> String {
    return try self.prettyHTMLLines._description(indent: indent, newline: newline)
  }
  
  /// Returns prettified XHTML String.
  public final var prettyXHTMLString: String {
    return prettyXHTMLString()
  }

  /// Returns prettified HTML String.
  public final var prettyHTMLString: String {
    get throws {
      return try prettyHTMLString()
    }
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
  
  /// Removes leading and trailing whitespaces in each node if necessary.
  ///
  /// Expected to be overridden in subclasses.
  internal func _trimTexts() {
    
  }

  /// Interpolates the instance with `amender`.
  /// An argument of `amender` is the instance itself, or
  /// one of its children if the receiver is `Element`.
  open func interpolate(_ amender: (Node) throws -> Void) rethrows {
    try amender(self)
  }
}

