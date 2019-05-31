#if !canImport(ObjectiveC)
import XCTest

extension AttributesTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__AttributesTests = [
        ("test_initialzation", test_initialzation),
        ("test_namespace", test_namespace),
    ]
}

extension CommentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__CommentTests = [
        ("test_comment", test_comment),
        ("test_prettyXHTMLString", test_prettyXHTMLString),
    ]
}

extension DocumentTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__DocumentTests = [
        ("test_detectXHTMLInfo", test_detectXHTMLInfo),
        ("test_initialization", test_initialization),
        ("test_template", test_template),
        ("test_title", test_title),
        ("test_tree", test_tree),
    ]
}

extension ElementTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ElementTests = [
        ("test_classSelector", test_classSelector),
        ("test_equatable", test_equatable),
        ("test_globalAttributes", test_globalAttributes),
        ("test_id", test_id),
        ("test_namespace", test_namespace),
        ("test_prettyXHTMLString", test_prettyXHTMLString),
        ("test_xhtmlString", test_xhtmlString),
    ]
}

extension NamesTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__NamesTests = [
        ("test_attributeName", test_attributeName),
        ("test_NCName", test_NCName),
        ("test_QName", test_QName),
    ]
}

extension Node_XMLNodeTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__Node_XMLNodeTests = [
        ("test_attributes", test_attributes),
        ("test_comment", test_comment),
        ("test_node", test_node),
        ("test_processingInstruction", test_processingInstruction),
        ("test_text", test_text),
    ]
}

extension ParserTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ParserTests = [
        ("test_errors", test_errors),
        ("test_parseSimpleXHTML5", test_parseSimpleXHTML5),
    ]
}

extension ProcessingInstructionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__ProcessingInstructionTests = [
        ("test_XMLStyleSheet", test_XMLStyleSheet),
    ]
}

extension VersionTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__VersionTests = [
        ("test_initialization", test_initialization),
    ]
}

public func __allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AttributesTests.__allTests__AttributesTests),
        testCase(CommentTests.__allTests__CommentTests),
        testCase(DocumentTests.__allTests__DocumentTests),
        testCase(ElementTests.__allTests__ElementTests),
        testCase(NamesTests.__allTests__NamesTests),
        testCase(Node_XMLNodeTests.__allTests__Node_XMLNodeTests),
        testCase(ParserTests.__allTests__ParserTests),
        testCase(ProcessingInstructionTests.__allTests__ProcessingInstructionTests),
        testCase(VersionTests.__allTests__VersionTests),
    ]
}
#endif
