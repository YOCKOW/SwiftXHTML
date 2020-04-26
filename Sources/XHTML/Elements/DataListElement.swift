/* *************************************************************************************************
 DataListElement.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class DataListElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "datalist"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
  
  public convenience init<S>(
    xhtmlPrefix: QualifiedName.Prefix = .none,
    identifier: String,
    options: S
  ) throws where S: Sequence, S.Element: OptionElement {
    try self.init(xhtmlPrefix: xhtmlPrefix, attributes: ["id": identifier], children: Array(options))
  }
  
  public convenience init<S>(
    xhtmlPrefix: QualifiedName.Prefix = .none,
    identifier: String,
    values: S
  ) throws where S: Sequence, S.Element: StringProtocol {
    try self.init(
      xhtmlPrefix: xhtmlPrefix,
      identifier: identifier,
      options: try values.map({ try OptionElement(xhtmlPrefix: xhtmlPrefix, value: String($0), text: "") })
    )
  }
}
