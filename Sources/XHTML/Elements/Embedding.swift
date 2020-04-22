/* *************************************************************************************************
 Embedding.swift
   © 2020 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */
 
open class AudioElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "audio"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class EmbeddedElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "embed"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class ImageElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "img"
  }
  
  public final override var isEmpty: Bool {
    return true
  }
}

open class ImageAreaElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "area"
  }
  
  public final override var isEmpty: Bool {
    return true
  }
}

open class ImageMapElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "map"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class InlineFrameElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "iframe"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class MediaSourceElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "source"
  }
  
  public final override var isEmpty: Bool {
    return true
  }
}

open class ObjectElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "object"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class ParameterElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "param"
  }
  
  public final override var isEmpty: Bool {
    return true
  }
}

open class PictureElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "picture"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}

open class TextTrackElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "track"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}


open class VideoElement: SpecifiedElement {
  public final override class var localName: NoncolonizedName {
    return "video"
  }
  
  public final override var isEmpty: Bool {
    return false
  }
}
