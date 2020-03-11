import XCTest
@testable import SwiftUICell

@available(iOS 13.0, *)
final class SwiftUICellTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        let cell: SwiftUICell = SwiftUICell<ContentView>()
        XCTAssertNotNil(cell)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
