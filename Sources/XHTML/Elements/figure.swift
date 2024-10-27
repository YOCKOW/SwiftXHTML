/* *************************************************************************************************
 Figure.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

/// Represents \<figure>\</figure>
open class FigureElement: SpecifiedElement, BlockLevelElement {
  public final override class var localName: NoncolonizedName {
    return "figure"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

/// Represents \<figcaption>\</figcaption>
open class FigureCaptionElement: SpecifiedElement, BlockLevelElement, InitializableWithSimpleTextContent {
  public final override class var localName: NoncolonizedName {
    return "figcaption"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
