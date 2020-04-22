/* *************************************************************************************************
 Modification.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class InsertionElement: SpecifiedElement {
   public final override class var localName: NoncolonizedName {
     return "ins"
   }
   
   public final override var isEmpty: Bool {
     return false
   }
}

open class DeletionElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "del"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

