/* *************************************************************************************************
 TextMeaning.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class AbbreviationElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "abbr"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none,
                          fullForm: String? = nil, abbreviation: String) throws {
    try self.init(xhtmlPrefix: xhtmlPrefix, children: [.text(abbreviation)])
    if let fullForm = fullForm {
      self.globalAttributes.title = fullForm
    }
  }
}

open class BidirectionalIsolateElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "bdi"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class BidirectionalTextOverrideElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "bdo"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class CitationElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "cite"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class CodeElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "code"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class DataElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "data"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
  
  public convenience init(xhtmlPrefix: QualifiedName.Prefix = .none, value: String, text: String) throws {
    try self.init(xhtmlPrefix: xhtmlPrefix, attributes: ["value": value], children: [.text(text)])
  }
}

open class EmphasisElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "em"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class KeyboardInputElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "kbd"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class MarkTextElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "mark"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class QuotationElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "q"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class SampleElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "samp"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class SmallElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "small"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class StrikedElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "s"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class StrongElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "strong"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class SubscriptElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "sub"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class SuperscriptElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "sup"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class TimeElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "time"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class VariableElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "var"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}



