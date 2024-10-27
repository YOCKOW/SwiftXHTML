/* *************************************************************************************************
 Description.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<dl\>\</dl\>.
open class DescriptionListElement: SpecifiedElement, BlockLevelElement {
  public final override class var localName: NoncolonizedName {
    return "dl"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

/// Represents \<dt\>\</dt\>.
open class DescriptionTermElement: SpecifiedElement, BlockLevelElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "dt"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

/// Represents \<dd\>\</dd\>.
open class DescriptionElement: SpecifiedElement, BlockLevelElement, InitializableWithSimpleTextContent {
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
