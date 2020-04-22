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
  
  public required init(name: QualifiedName, attributes: Attributes) {
    super.init(name: name, attributes: attributes)
  }
  
  public required init(name: QualifiedName, attributes: Attributes, children: [Node]) {
    super.init(name: name, attributes: attributes, children: children)
  }
  
  public convenience init(name: QualifiedName = "ruby",
                          attributes: Attributes = [:],
                          text: String, rubyText: String, includesFallbackParenthesis: Bool = false) {
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
    self.init(name: name, attributes: attributes, children: children)
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
