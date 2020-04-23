/* *************************************************************************************************
 Ruby.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class RubyElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "ruby"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
  
  public required init(name: QualifiedName, attributes: Attributes = [:], children: [Node] = []) throws {
    try super.init(name: name, attributes: attributes, children: children)
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none,
                          attributes: Attributes = [:],
                          text: String, rubyText: String, includesFallbackParenthesis: Bool = false) throws {
    var children: [Node] = []
    children.append(.text(text))
    if includesFallbackParenthesis {
      children.append(.rp(children:[
        .text("(")
      ]))
    }
    children.append(.rt(children: [.text(rubyText)]))
    if includesFallbackParenthesis {
      children.append(.rp(children:[
        .text(")")
      ]))
    }
    try self.init(name: QualifiedName(prefix: xhtmlPrefix, localName: type(of: self).localName),
                  attributes: attributes, children: children)
  }
}

open class RubyFallbackParenthesisTextElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "rp"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class RubyTextElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "rt"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class RubyTextContainerElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "rtc"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
