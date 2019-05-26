/* *************************************************************************************************
 Element+ClassSelector.swift
   © 2019 YOCKOW.
     Licensed under MIT License.
     See "LICENSE.txt" for more information.
 ************************************************************************************************ */

extension Element {
  /// The class to select a class that the parser will use to create element instances.
  /// The registered classes will not be used
  /// if the namespace of the QName of the element is not XHTML's.
  public final class ClassSelector {
    private init() {}
    public static let `default`: ClassSelector = .init()
    
    private var _list:[NoncolonizedName:Element.Type] = [
      "a":AnchorElement.self,
      "body":BodyElement.self,
      "br":LineBreakElement.self,
      "form":FormElement.self,
      "head":HeadElement.self,
      "input":InputElement.self,
      "title":TitleElement.self,
    ]
    
    /// Register `class` for the element whose local name is `localName`.
    public func register(_ class:Element.Type, for localName:NoncolonizedName) {
      self._list[localName] = `class`
    }
    
    internal func _class(for localName:NoncolonizedName) -> Element.Type? {
      return self._list[localName]
    }
  }
}

internal protocol _ElementClassSelector {}
extension Element: _ElementClassSelector {}
extension _ElementClassSelector {
  private static func _canBeRootElement(name: QualifiedName, attributes: Attributes) -> Bool {
    return name.localName == "html" && attributes._namespace(for:name)?._isXHTMLNamespace == true
  }
  
  private static func _forceGenerateElement(name: QualifiedName, attributes: Attributes) -> Self? {
    if let cls = Element.ClassSelector.default._class(for:name.localName) {
      return (cls.init(name:name, attributes:attributes) as! Self)
    }
    return nil
  }
  
  internal init(name:QualifiedName,
                attributes:Attributes,
                parent:Element?)
  {
    if Self._canBeRootElement(name: name, attributes: attributes) {
      self = HTMLElement(name:name, attributes:attributes) as! Self
      return
    }
    
    let namespaceIsXHTML: Bool = ({
      if let ns = attributes.namespace(for:name), ns._isXHTMLNamespace {
        return true
      }
      if let ns = parent?.namespace(for:name), ns._isXHTMLNamespace {
        return true
      }
      return false
    })()
    
    if namespaceIsXHTML {
      if let instance = Self._forceGenerateElement(name: name, attributes: attributes) {
        self = instance
        return
      }
    }
  
    self = Element(name:name, attributes:attributes) as! Self
  }
  
  internal init(name: QualifiedName,
                attributes: Attributes,
                xhtmlPrefix: NoncolonizedName?) {
    if Self._canBeRootElement(name: name, attributes: attributes) {
      self = HTMLElement(name:name, attributes:attributes) as! Self
      return
    }
    
    if name.prefix == xhtmlPrefix {
      if let instance = Self._forceGenerateElement(name: name, attributes: attributes) {
        self = instance
        return
      }
    }
    
    self = Element(name:name, attributes:attributes) as! Self
  }
}
