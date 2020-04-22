/* *************************************************************************************************
 Figure.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class FigureElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "figure"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class FigureCaptionElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "figcaption"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
