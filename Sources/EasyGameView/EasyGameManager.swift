import SwiftUI

/// A class that provides observable objects for the `EasyGameView`
public class EasyGameManager: ObservableObject {

    /// A representation of the state for our EasyGameView. This is essentially
    /// a multidimensional array of integers, with lots of helper functions.
    @Published var game: EasyGameState

    /// A published object used to configure the EasyGameView.
    @Published var config: EasyGameViewConfiguration

    /// A published object for providing state colors.
    @Published var stateColorProvider: EasyGameSubviewColorProvider

    /// A published object for providing state to text subviews.
    @Published var stateTextProvider: EasyGameSubviewTextProvider

    public init(game: EasyGameState = EasyGameState(),
                config: EasyGameViewConfiguration = EasyGameViewConfiguration(),
                colorProvider: EasyGameSubviewColorProvider = EasyGameSubviewColorProviderDefault(),
                textProvider: EasyGameSubviewTextProvider = EasyGameSubviewTextProviderDefault()) {
        self.game = game
        self.config = config
        self.stateColorProvider = colorProvider
        self.stateTextProvider = textProvider
    }

    /// called by our subviews to populate color states
    public func colorForIndex(index: Int) -> Color {
        let state = game.stateAt(index: index)
        return stateColorProvider.colorForState(state: state)
    }

    /// called by our subviews to populate text states
    public func textForIndex(index: Int) -> String {
        let state = game.stateAt(index: index)
        return stateTextProvider.textForState(state: state)
    }
}
