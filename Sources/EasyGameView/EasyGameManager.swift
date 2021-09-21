import SwiftUI

/// A class that provides observable objects for the `EasyGameView`
public class EasyGameManager: ObservableObject {

    /// A representation of the state for our EasyGameView. This is essentially
    /// a multidimensional array of integers, with lots of helper functions.
    @Published public var game: EasyGameState

    /// A published object used to configure the EasyGameView.
    @Published public var config: EasyGameViewConfiguration

    /// A published object holding various subview data.
    @Published public var data: EasyGameViewData

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

        self.data = EasyGameViewData(subviewCount: game.gridCount)
    }

    // MARK: handling gestures

    /// called by subviews to handle drag continued
    public func handleDragContinued(atIndex index: Int, withGestureValue value: DragGesture.Value) {
        gestureHandlerForDrag.handleDragContinued(
            forIndex: index,
            withGestureValue: value,
            inManager: self)
    }

    /// called by subviews to handle drag ended
    public func handleDragEnded(atIndex index: Int, withGestureValue value: DragGesture.Value) {
        gestureHandlerForDrag.handleDragEnded(
            forIndex: index,
            withGestureValue: value,
            inManager: self)
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

    // MARK: coordinates and points

    /// Get the coordinate point for a given pixel `CGPoint`.
    /// - Parameter pixelPoint: A pixel coordinate, presumably within the bounds of this view.
    /// - Returns: A `EasyGameState.Point` containing coordinates corresponding to x,y values in our game object.
    public func coordinatePointFor(pixelPoint: CGPoint) -> EasyGameState.Point {
        guard CGRect(x: 0.0, y: 0.0, width: data.totalSize.width, height: data.totalSize.height).contains(pixelPoint) else {
            return (x: -1, y: -1);
        }
        switch config.gridType {
        case .color, .hexUpDown, .text:
            let x = Int(pixelPoint.x / data.subviewSize.width);
            let y = Int(pixelPoint.y / data.subviewSize.height);
            return (x: x, y: y)
        }
    }

}
