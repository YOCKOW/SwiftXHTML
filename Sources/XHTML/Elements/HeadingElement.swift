/* *************************************************************************************************
 HeadingElement.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class HeadingElement: SpecifiedElement, InitializableWithSimpleTextContent {}

open class H1Element: HeadingElement {
  public override class final var localName: NoncolonizedName { return "h1" }
}

open class H2Element: HeadingElement {
  public override class final var localName: NoncolonizedName { return "h2" }
}

open class H3Element: HeadingElement {
  public override class final var localName: NoncolonizedName { return "h3" }
}

open class H4Element: HeadingElement {
  public override class final var localName: NoncolonizedName { return "h4" }
}

open class H5Element: HeadingElement {
  public override class final var localName: NoncolonizedName { return "h5" }
}

open class H6Element: HeadingElement {
  public override class final var localName: NoncolonizedName { return "h6" }
}
