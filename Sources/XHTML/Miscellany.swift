/* *************************************************************************************************
 Miscellany.swift
   © 2019,2023 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
import StringComposition

/// Represents List of [Misc.](https://www.w3.org/TR/REC-xml/#NT-Misc)
public final class Miscellany: Node {
  private enum _Node {
    case comment(Comment)
    case processingInstruction(ProcessingInstruction)
  }
  
  private var _node: _Node
  
  public override var xhtmlString: String {
    switch self._node {
    case .comment(let comment): return comment.xhtmlString
    case .processingInstruction(let pi): return pi.xhtmlString
    }
  }

  public override var htmlString: String {
    get throws {
      switch _node {
      case .comment(let comment): return try comment.htmlString
      case .processingInstruction(let pi): return try pi.htmlString
      }
    }
  }
  
  public override var prettyXHTMLLines: StringLines {
    switch self._node {
    case .comment(let comment): return comment.prettyXHTMLLines
    case .processingInstruction(let pi): return pi.prettyXHTMLLines
    }
  }

  public override var prettyHTMLLines: StringLines {
    get throws {
      switch _node {
      case .comment(let comment): return try comment.prettyHTMLLines
      case .processingInstruction(let pi): return try pi.prettyHTMLLines
      }
    }
  }
  
  public init?(_ node:Node) {
    if case let misc as Miscellany = node {
      self._node = misc._node
    } else if case let comment as Comment = node {
      self._node = .comment(comment)
    } else if case let pi as ProcessingInstruction = node {
      self._node = .processingInstruction(pi)
    } else {
      return nil
    }
  }
}

extension Sequence where Self.Element == Miscellany {
  public var xhtmlString: String {
    return self.map { $0.xhtmlString }.joined()
  }

  public var htmlString: String {
    get throws {
      return try self.map { try $0.htmlString }.joined()
    }
  }
  
  public var prettyXHTMLLines: StringLines {
    return StringLines(self.flatMap({ $0.prettyXHTMLLines }))
  }

  public var prettyHTMLLines: StringLines {
    get throws {
      return StringLines(try self.flatMap { try $0.prettyHTMLLines })
    }
  }
  
  public func prettyXHTMLString(indent: String.Indent = .default,
                                newline: Character.Newline = .lineFeed) -> String {
    return self.prettyXHTMLLines._description(indent: indent, newline: newline)
  }

  public func prettyHTMLString(
    indent: String.Indent = .default,
    newline: Character.Newline = .lineFeed
  ) throws -> String {
    return try prettyHTMLLines._description(indent: indent, newline: newline)
  }
}
