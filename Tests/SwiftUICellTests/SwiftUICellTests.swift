import XCTest
@testable import SwiftUICell

final class SwiftUICellTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let cell: SwiftUICell = SwiftUICell
        XCTAssertEqual(SwiftUICell().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
