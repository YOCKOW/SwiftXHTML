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
      "a": AnchorElement.self,
      "abbr": AbbreviationElement.self,
      "address": AddressElement.self,
      "area": ImageAreaElement.self,
      "article": ArticleElement.self,
      "aside": AsideElement.self,
      "audio": AudioElement.self,
      "bdi": BidirectionalIsolateElement.self,
      "bdo": BidirectionalTextOverrideElement.self,
      "blockquote": BlockQuoteElement.self,
      "body": BodyElement.self,
      "br": LineBreakElement.self,
      "button": ButtonElement.self,
      "canvas": CanvasElement.self,
      "caption": TableCaptionElement.self,
      "cite": CitationElement.self,
      "code": CodeElement.self,
      "data": DataElement.self,
      "datalist": DataListElement.self,
      "dd": DescriptionElement.self,
      "del": DeletionElement.self,
      "dfn": DefinitionElement.self,
      "dl": DescriptionListElement.self,
      "dt": DescriptionTermElement.self,
      "em": EmphasisElement.self,
      "embed": EmbeddedElement.self,
      "fieldset": FieldSetElement.self,
      "figcaption": FigureCaptionElement.self,
      "figure": FigureElement.self,
      "form": FormElement.self,
      "h1": H1Element.self,
      "h2": H2Element.self,
      "h3": H3Element.self,
      "h4": H4Element.self,
      "h5": H5Element.self,
      "h6": H6Element.self,
      "head": HeadElement.self,
      "header": HeaderElement.self,
      "hr": HorizontalRuleElement.self,
      "iframe": InlineFrameElement.self,
      "img": ImageElement.self,
      "input": InputElement.self,
      "ins": InsertionElement.self,
      "kbd": KeyboardInputElement.self,
      "label": LabelElement.self,
      "legend": LegendElement.self,
      "link": LinkElement.self,
      "main": MainElement.self,
      "map": ImageMapElement.self,
      "mark": MarkTextElement.self,
      "meta": MetaElement.self,
      "meter": MeterElement.self,
      "nav": NavigationElement.self,
      "noscript": NoScriptElement.self,
      "object": ObjectElement.self,
      "optgroup": OptionGroupElement.self,
      "option": OptionElement.self,
      "output": OutputElement.self,
      "p": ParagraphElement.self,
      "param": ParameterElement.self,
      "picture": PictureElement.self,
      "pre": PreformattedTextElement.self,
      "progress": ProgressIndicatorElement.self,
      "q": QuotationElement.self,
      "ruby": RubyElement.self,
      "rp": RubyFallbackParenthesisTextElement.self,
      "rt": RubyTextElement.self,
      "rtc": RubyTextContainerElement.self,
      "samp": SampleElement.self,
      "script": ScriptElement.self,
      "section": SectionElement.self,
      "select": SelectionElement.self,
      "small": SmallElement.self,
      "span": SpanElement.self,
      "s": StrikedElement.self,
      "source": MediaSourceElement.self,
      "strong": StrongElement.self,
      "style": StyleElement.self,
      "sub": SubscriptElement.self,
      "sup": SuperscriptElement.self,
      "table": TableElement.self,
      "tbody": TableBodyElement.self,
      "td": TableDataCellElement.self,
      "template": TemplateElement.self,
      "textarea": TextAreaElement.self,
      "tfoot": TableFooterElement.self,
      "th": TableHeaderCellElement.self,
      "thead": TableHeaderElement.self,
      "time": TimeElement.self,
      "title": TitleElement.self,
      "tr": TableRowElement.self,
      "track": TextTrackElement.self,
      "var": VariableElement.self,
      "video": VideoElement.self,
      "wbr": WordBreakElement.self,
    ]
    
    /// The type for `localName` that the parser uses when create an element instance.
    public subscript(_ localName: NoncolonizedName) -> Element.Type? {
      get {
        return self._list[localName]
      }
      set {
        self._list[localName] = newValue
      }
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
    if let cls = Element.ClassSelector.default[name.localName] {
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
                xhtmlPrefix: QualifiedName.Prefix) {
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
