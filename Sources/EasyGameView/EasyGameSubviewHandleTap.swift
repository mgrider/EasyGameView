import SwiftUI

public protocol EasyGameSubviewHandleTap {
    /// handles a tap at the index, returns a modified state/game
    func handleTap(forIndex index: Int, inGame game: EasyGameState) -> EasyGameState
}

public struct EasyGameSubviewHandleTapDefault: EasyGameSubviewHandleTap {

    public func handleTap(forIndex index: Int, inGame game: EasyGameState) -> EasyGameState {
        var game = game
        guard var state = game.stateAt(index: index) else {
            game.setState(atIndex: index, to: game.stateDefault)
            return game
        }
        state += 1
        if state > game.stateMax {
            state = game.stateDefault
        }
        game.setState(atIndex: index, to: state)
        return game
    }

    public init() {}
}
