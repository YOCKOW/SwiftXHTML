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

open class EmbeddedElement: PerpetuallyEmptyElement {
  public final override class var localName: NoncolonizedName {
    return "embed"
  }
}

open class ImageElement: PerpetuallyEmptyElement {
  public final override class var localName: NoncolonizedName {
    return "img"
  }
}

open class ImageAreaElement: PerpetuallyEmptyElement {
  public final override class var localName: NoncolonizedName {
    return "area"
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

open class MediaSourceElement: PerpetuallyEmptyElement {
  public final override class var localName: NoncolonizedName {
    return "source"
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

open class ParameterElement: PerpetuallyEmptyElement {
  public final override class var localName: NoncolonizedName {
    return "param"
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

open class TextTrackElement: PerpetuallyEmptyElement {
  public final override class var localName: NoncolonizedName {
    return "track"
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
