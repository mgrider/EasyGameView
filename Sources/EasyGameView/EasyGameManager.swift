import SwiftUI

/// A class that provides observable objects for the `EasyGameView`
public class EasyGameManager: ObservableObject {

    /// A representation of the state for our EasyGameView. This is essentially
    /// a multidimensional array of integers, with lots of helper functions.
    @Published public var game: EasyGameState

    /// A published object used to configure the EasyGameView.
    @Published public var config: EasyGameViewConfiguration

    /// An object that handles tap gestures.
    var gestureHandlerForTaps: EasyGameSubviewHandleTap

    /// An object that handles drag gestures.
    var gestureHandlerForDrag: EasyGameSubviewHandleDrag

    /// A published object for providing state colors.
    var stateColorProvider: EasyGameSubviewStateProviderColor

    /// A published object for providing state to text subviews.
    var stateTextProvider: EasyGameSubviewStateProviderText

    public init(game: EasyGameState = EasyGameState(),
                colorProvider: EasyGameSubviewStateProviderColor = EasyGameSubviewStateProviderColorDefault(),
                config: EasyGameViewConfiguration = EasyGameViewConfiguration(),
                handlerForDrag: EasyGameSubviewHandleDrag = EasyGameSubviewHandleDragDefault(),
                handlerForTap: EasyGameSubviewHandleTap = EasyGameSubviewHandleTapDefault(),
                textProvider: EasyGameSubviewStateProviderText = EasyGameSubviewStateProviderTextDefault()) {
        self.game = game
        self.config = config
        self.gestureHandlerForDrag = handlerForDrag
        self.gestureHandlerForTaps = handlerForTap
        self.stateColorProvider = colorProvider
        self.stateTextProvider = textProvider
    }
    
    // MARK: handling gestures

    /// called by subviews to handle drag continued
    public func handleDragContinued(atIndex index: Int, withOffset offset: CGSize) {
        game = gestureHandlerForDrag.handleDragContinued(
            forIndex: index,
            withOffset: offset,
            inGame: game,
            withConfiguration: config)
    }

    /// called by subviews to handle drag ended
    public func handleDragEnded(atIndex index: Int, withOffset offset: CGSize) {
        game = gestureHandlerForDrag.handleDragEnded(
            forIndex: index,
            withOffset: offset,
            inGame: game,
            withConfiguration: config)
    }

    /// called by subviews to handle taps
    public func handleTap(atIndex index: Int) {
        game = gestureHandlerForTaps.handleTap(forIndex: index, inGame: game)
    }

    // MARK: subview states

    /// called by our subviews to populate color states
    public func stateColor(forIndex index: Int) -> Color {
        let state = game.stateAt(index: index)
        return stateColorProvider.colorForState(state: state)
    }

    /// called by our subviews to populate text states
    public func stateText(forIndex index: Int) -> String {
        let state = game.stateAt(index: index)
        return stateTextProvider.textForState(state: state)
    }
}
