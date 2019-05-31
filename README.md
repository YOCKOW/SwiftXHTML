# What is `SwiftXHTML`?

`SwiftXHTML` will provide some functions related to XHTML.  
It was originally written as a part of [SwiftCGIResponder](https://github.com/YOCKOW/SwiftCGIResponder),
and is intended to be used by it.


# Requirements

- Swift 5 (including compatibility mode for Swift 4 or 4.2)
- macOS or Linux

## Dependencies

* [SwiftBonaFideCharacterSet](https://github.com/YOCKOW/SwiftBonaFideCharacterSet)
* [SwiftExtensions](https://github.com/YOCKOW/SwiftExtensions)
* [SwiftNetworkGear](https://github.com/YOCKOW/SwiftNetworkGear)
* [SwiftPredicate](https://github.com/YOCKOW/SwiftPredicate)
* [SwiftRanges](https://github.com/YOCKOW/SwiftRanges)


# Usage

```Swift
import XHTML

let page = Document.template(title: "Title")
page.rootElement.body!.append(.text("It's my page."))
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


# License

MIT License.  
See "LICENSE.txt" for more information.

