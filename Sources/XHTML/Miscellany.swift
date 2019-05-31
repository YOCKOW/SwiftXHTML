/* *************************************************************************************************
 Miscellany.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
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
  
  internal override var _prettyXHTMLStringLines: [String] {
    switch self._node {
    case .comment(let comment): return comment._prettyXHTMLStringLines
    case .processingInstruction(let pi): return pi._prettyXHTMLStringLines
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
  
  internal var _prettyXHTMLStringLines: [String] {
    var lines: [String] = []
    for misc in self {
      var miscLines = misc._prettyXHTMLStringLines
      if let lastLine = miscLines.last, !lastLine._endsWithNewline {
        miscLines.removeLast()
        miscLines.append(lastLine + "\n")
      }
      lines.append(contentsOf: miscLines)
    }
    return lines
  }
  
  public var prettyXHTMLString: String {
    return self._prettyXHTMLStringLines.joined()
  }
}
