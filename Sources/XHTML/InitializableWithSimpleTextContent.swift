/* *************************************************************************************************
 InitializableWithSimpleTextContent.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
public protocol InitializableWithSimpleTextContent where Self: Element {
  init(name: QualifiedName, attributes: Attributes, text: String) throws
}

extension InitializableWithSimpleTextContent {
  public init(name: QualifiedName, attributes: Attributes = [:], text: String) throws {
    try self.init(name: name, attributes: attributes, children: [.text(text)])
  }
}

extension InitializableWithSimpleTextContent where Self: SpecifiedElement {
  public init(xhtmlPrefix: QualifiedName.Prefix = .none, attributes: Attributes = [:], text: String) throws {
    try self.init(
      name: QualifiedName(prefix: xhtmlPrefix, localName: type(of: self).localName),
      attributes: attributes,
      text: text
    )
  }
}
