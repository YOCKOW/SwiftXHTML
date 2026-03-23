# What is `SwiftXHTML`?

`SwiftXHTML` will provide some functions related to XHTML.  
It was originally written as a part of [SwiftCGIResponder](https://github.com/YOCKOW/SwiftCGIResponder),
and is intended to be used by it.


# Requirements

- Swift >=6.2
- macOS(>=13) or Linux


## Dependencies

<!-- SWIFT PACKAGE DEPENDENCIES MERMAID START -->
```mermaid
---
title: XHTML Dependencies
---
flowchart TD
  swiftbootstring(["Bootstring<br>@1.2.0"])
  swiftnetworkgear(["NetworkGear<br>@0.20.0"])
  swiftpublicsuffix(["PublicSuffix<br>@2.4.13"])
  swiftranges(["Ranges<br>@4.0.1"])
  swiftstringcomposition(["StringComposition<br>@3.0.0"])
  swifttemporaryfile(["TemporaryFile<br>@5.0.0"])
  swiftunicodesupplement(["UnicodeSupplement<br>@2.0.0"])
  swiftxhtml["XHTML"]
  yswiftextensions(["yExtensions<br>@2.0.0"])

  click swiftbootstring href "https://github.com/YOCKOW/SwiftBootstring.git"
  click swiftnetworkgear href "https://github.com/YOCKOW/SwiftNetworkGear.git"
  click swiftpublicsuffix href "https://github.com/YOCKOW/SwiftPublicSuffix.git"
  click swiftranges href "https://github.com/YOCKOW/SwiftRanges.git"
  click swiftstringcomposition href "https://github.com/YOCKOW/SwiftStringComposition.git"
  click swifttemporaryfile href "https://github.com/YOCKOW/SwiftTemporaryFile.git"
  click swiftunicodesupplement href "https://github.com/YOCKOW/SwiftUnicodeSupplement.git"
  click yswiftextensions href "https://github.com/YOCKOW/ySwiftExtensions.git"

  swiftnetworkgear ----> swiftbootstring
  swiftnetworkgear ----> swiftpublicsuffix
  swiftnetworkgear ----> swiftranges
  swiftnetworkgear --> swifttemporaryfile
  swiftnetworkgear --> swiftunicodesupplement
  swiftnetworkgear --> yswiftextensions
  swiftstringcomposition --> yswiftextensions
  swifttemporaryfile ----> swiftranges
  swifttemporaryfile --> yswiftextensions
  swiftunicodesupplement ----> swiftranges
  swiftxhtml --> swiftnetworkgear
  swiftxhtml ----> swiftranges
  swiftxhtml --> swiftstringcomposition
  swiftxhtml --> swiftunicodesupplement
  swiftxhtml --> yswiftextensions
  yswiftextensions ----> swiftranges
  yswiftextensions --> swiftunicodesupplement


```
<!-- SWIFT PACKAGE DEPENDENCIES MERMAID END -->


# Usage

## As a parser

```Swift
import XHTML

let string = """
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
  <head>
    <title>Title</title>
  </head>
  <body>
    <div id="main">
      <h1>My Page</h1>
      <p>Welcome to my page.</p>
    </div>
  </body>
</html>
"""

let document = try Parser.parse(string.data(using: .utf8)!)

print(document.prolog.xmlVersion) // -> "1.0"
print(document.element(for: "main")!.name) // -> "div"

```


## As a generator

```Swift
import XHTML

let page = Document.template(title: "Title",
                             contents:[.text("It's my page.")])
print(page.xhtmlString)

/*
-- OUTPUT --
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml"><head><title>Title</title></head><body>It&apos;s my page.</body></html>

*/

page.rootElement.body!.append(.comment("This is a comment."))
print(page.prettyXHTMLString)

/*
-- OUTPUT --
<?xml version="1.0" encoding="utf-8"?>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head><title>Title</title></head>
    <body>
        It&apos;s my page.
        <!--This is a comment.-->
    </body>
</html>

*/
```


## What are not supported yet...

- XPath
- CSS selector
- CSS parser


# License

MIT License.  
See "LICENSE.txt" for more information.

