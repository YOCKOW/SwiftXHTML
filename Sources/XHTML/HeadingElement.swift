/* *************************************************************************************************
 HeadingElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class HeadingElement: SpecifiedElement {}

open class H1Element: HeadingElement {
  open override class var localName: NoncolonizedName { return "h1" }
}

open class H2Element: HeadingElement {
  open override class var localName: NoncolonizedName { return "h2" }
}

open class H3Element: HeadingElement {
  open override class var localName: NoncolonizedName { return "h3" }
}

open class H4Element: HeadingElement {
  open override class var localName: NoncolonizedName { return "h4" }
}

open class H5Element: HeadingElement {
  open override class var localName: NoncolonizedName { return "h5" }
}

open class H6Element: HeadingElement {
  open override class var localName: NoncolonizedName { return "h6" }
}