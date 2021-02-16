/* *************************************************************************************************
 Scripting.swift
   © 2020-2021 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class CanvasElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "canvas"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class NoScriptElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "noscript"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class ScriptElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "script"
  }

  public final override var isEmpty: Bool {
    return false
  }
}

open class TemplateElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "template"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
