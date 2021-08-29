    import XCTest
    @testable import EasyGameView

    final class EasyGameViewTests: XCTestCase {
        func testExample() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct
            // results.
//            XCTAssertEqual(EasyGameView().text, "Hello, World!")
            XCTAssertEqual(EasyGameView().manager.game.gridWidth, 8)
            XCTAssertEqual(EasyGameView().manager.game.isOver, false)
        }
    }
