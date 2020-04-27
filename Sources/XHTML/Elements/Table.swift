/* *************************************************************************************************
 Table.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class TableElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "table" }
  
  public override final var isEmpty: Bool { return false }
  
  private func _firstElement<T>(type: T.Type) -> T? {
    for child in self.children {
      if case let element as T = child { return element }
    }
    return nil
  }
  
  /// Returns \<thead>\</thead>
  open var header: TableHeaderElement? {
    return self._firstElement(type: TableHeaderElement.self)
  }
  
  /// Returns \<tbody>\</tbody>
  open var body: TableBodyElement? {
    return self._firstElement(type: TableBodyElement.self)
  }
  
  /// Returns \<tfoot>\</tfoot>
  open var footer: TableFooterElement? {
    return self._firstElement(type: TableFooterElement.self)
  }
  
  /// Returns \<tr>\</tr> at `index`.
  /// When, for example, `header` contains 2 rows and `body` contains 3 rows,
  /// `row` at #3 is the middle row of `body`.
  open func row(at index: Int) -> TableRowElement {
    var ii = 0
    
    func _search(_ rows: TableRowsElement) -> TableRowElement? {
      for row in rows {
        if ii == index { return row }
        ii += 1
      }
      return nil
    }
    
    if let row = self.header.flatMap(_search) { return row }
    if let row = self.body.flatMap(_search) { return row }
    if let row = self.footer.flatMap(_search) { return row }
    
    fatalError("Out of bounds.")
  }
}

open class TableCaptionElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public override class final var localName: NoncolonizedName { return "caption" }
  public override final var isEmpty: Bool { return false }
}

/// The abstract class for `TableHeadElement`, `TableBodyElement`, and `TableFootElement`.
open class TableRowsElement: SpecifiedElement {
  public override final var isEmpty: Bool { return false }
}

extension TableRowsElement: Sequence {
  public typealias Element = TableRowElement
  public struct Iterator: IteratorProtocol {
    public typealias Element = TableRowElement
    
    private var _scannedIndex: Int = -1
    private unowned var _element: TableRowsElement
    fileprivate init(_ element: TableRowsElement) { self._element = element }
    
    public mutating func next() -> TableRowElement? {
      let startIndex = self._scannedIndex + 1
      let endIndex = self._element.children.endIndex
      guard startIndex < endIndex else { return nil }
      
      for ii in startIndex ..< endIndex {
        if case let row as TableRowElement = self._element.children[ii] {
          self._scannedIndex = ii
          return row
        }
      }
      self._scannedIndex = endIndex
      return nil
    }
  }
  
  public func makeIterator() -> TableRowsElement.Iterator {
    return Iterator(self)
  }
  
  
  /// Returns \<tr>\</tr> at `index`.
  open subscript(_ index: Int) -> TableRowElement {
    var ii = 0
    for row in self {
      if ii == index { return row }
      ii += 1
    }
    fatalError("Out of bounds.")
  }
}

open class TableHeaderElement: TableRowsElement {
  public override class final var localName: NoncolonizedName { return "thead" }
}

open class TableBodyElement: TableRowsElement {
  public override class final var localName: NoncolonizedName { return "tbody" }
}

open class TableFooterElement: TableRowsElement {
  public override class final var localName: NoncolonizedName { return "tfoot" }
}

open class TableRowElement: SpecifiedElement {
  public override class final var localName: NoncolonizedName { return "tr" }
  
  public override final var isEmpty: Bool { return false }
  
  /// Returns \<th>\</th> or \<td>\</td> at `index`.
  /// \<th>\</th> is not counted when `includingHeaderCells` is false.
  open subscript(_ index: Int,
                 includingHeaderCells includingHeaderCells: Bool) -> TableCellElement
  {
    var ii = 0
    for child in self.children {
      if case let td as TableDataCellElement = child {
        if ii == index { return td }
        ii += 1
      } else if includingHeaderCells {
        if case let th as TableHeaderCellElement = child {
          if ii == index { return th }
          ii += 1
        }
      }
    }
    preconditionFailure("Out of bounds.")
  }
  
  open subscript(_ index: Int) -> TableCellElement {
    return self[index, includingHeaderCells: true]
  }
}

/// The abstract class for `TableHeaderCellElement`, and `TableDataCellElement`.
open class TableCellElement: SpecifiedElement {
  public override final var isEmpty: Bool { return false }
}

open class TableHeaderCellElement: TableCellElement {
  public override class final var localName: NoncolonizedName { return "th" }
}

open class TableDataCellElement: TableCellElement {
  public override class final var localName: NoncolonizedName { return "td" }
}

extension TableElement {
  /// Create a simple template of table.
  /// - parameter xhtmlPrefix: Namespace prefix for XHTML.
  /// - parameter attributes: The attributes.
  /// - parameter caption: The nodes to be children of \<caption>\</caption>
  /// - parameter numberOfHeaderRows: The number of header rows.
  /// - parameter numberOfHeaderColumns: The number of header columns.
  /// - parameter numberOfRows: The number of rows.
  /// - parameter numberOfColumns: The number of columns.
  /// - parameter numberOfFooterRows: The number of footer rows.
  /// - parameter contents: The contents of the table.
  ///                       It is an array of arrays: each `[Node]` represents the contents of row.
  ///                       It means `contents` parameter represents the collection of rows.
  public convenience init(
    xhtmlPrefix: QualifiedName.Prefix = .none,
    attributes: Attributes = [:],
    caption: [Node]? = nil,
    numberOfHeaderRows: Int = 0,
    numberOfHeaderColumns: Int = 0,
    numberOfRows: Int,
    numberOfColumns: Int,
    numberOfFooterRows: Int = 0
  ) throws {
    var indexOfRow = 0
    
    func _row(isInHeaderRow: Bool = false) throws -> TableRowElement {
      let row = try TableRowElement(xhtmlPrefix: xhtmlPrefix)
      
      for _ in 0..<numberOfHeaderColumns {
        row.append(try TableHeaderCellElement(xhtmlPrefix: xhtmlPrefix, attributes: ["scope":"row"]))
      }
      
      if isInHeaderRow {
        for _ in 0..<numberOfColumns {
          row.append(try TableHeaderCellElement(xhtmlPrefix: xhtmlPrefix, attributes: ["scope":"col"]))
        }
      } else {
        for _ in 0..<numberOfColumns {
          row.append(try TableDataCellElement(xhtmlPrefix: xhtmlPrefix))
        }
      }
      
      indexOfRow += 1
      return row
    }
    
    try self.init(xhtmlPrefix: xhtmlPrefix, attributes: attributes)
    if let captionContents = caption {
      self.append(try TableCaptionElement(xhtmlPrefix: xhtmlPrefix, children: captionContents))
    }
    
    precondition(numberOfHeaderRows >= 0, "The number of header rows must not be negative.")
    precondition(numberOfHeaderColumns >= 0, "The number of header columns must not be negative.")
    precondition(numberOfRows >= 0, "The number of rows must not be negative.")
    precondition(numberOfColumns >= 0, "The number of columns must not be negative.")
    precondition(numberOfFooterRows >= 0, "The number of footer rows must not be negative.")
    
    if numberOfHeaderRows > 0 {
      let thead = try TableHeaderElement(xhtmlPrefix: xhtmlPrefix)
      for _ in 0..<numberOfHeaderRows {
        thead.append(try _row(isInHeaderRow: true))
      }
      self.append(thead)
    }
    
    let tbody = try TableBodyElement(xhtmlPrefix: xhtmlPrefix)
    for _ in 0..<numberOfRows {
      tbody.append(try _row())
    }
    self.append(tbody)
    
    if numberOfFooterRows > 0 {
      let tfoot = try TableFooterElement(xhtmlPrefix: xhtmlPrefix)
      for _ in 0..<numberOfFooterRows {
        tfoot.append(try _row())
      }
      self.append(tfoot)
    }
  }
}
