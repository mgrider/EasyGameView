import SwiftUI

public protocol EasyGameSubviewHandleDrag {
    /// handles a drag for the subview at index, returns a modified state/game
    func handleDragContinued(forIndex index: Int, inGame game: EasyGameState) -> EasyGameState

    /// handles a drag ended for the subview at index, returns a modified state/game
    func handleDragEnded(forIndex index: Int, inGame game: EasyGameState) -> EasyGameState
}

public struct EasyGameSubviewHandleDragDefault: EasyGameSubviewHandleDrag {
    public func handleDragContinued(forIndex index: Int, inGame game: EasyGameState) -> EasyGameState {
        var game = game
        game.setState(atIndex: index, to: 2)
        return game
    }
    
    public func handleDragEnded(forIndex index: Int, inGame game: EasyGameState) -> EasyGameState {
        var game = game
        game.setState(atIndex: index, to: 3)
        return game
    }
    
    public init() {}
}
