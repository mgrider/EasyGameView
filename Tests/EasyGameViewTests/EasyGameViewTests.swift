    import XCTest
    @testable import EasyGameView

    final class EasyGameViewTests: XCTestCase {
        func testExample() {
            let view = EasyGameView()
            XCTAssertEqual(view.manager.game.gridWidth, 8)
            XCTAssertEqual(view.manager.game.isOver, false)
        }
    }
