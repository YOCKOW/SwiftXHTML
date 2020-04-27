/* *************************************************************************************************
 Description.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class DescriptionListElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "dl"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class DescriptionTermElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "dt"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class DescriptionElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "dd"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class DefinitionElement: SpecifiedElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "dfn"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
