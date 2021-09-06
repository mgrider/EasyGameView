import SwiftUI

public protocol EasyGameSubviewHandleDrag {
    /// handles a drag for the subview at index, returns a modified state/game
    func handleDragContinued(
        forIndex index: Int,
        withGestureValue value: DragGesture.Value,
        inManager manager: EasyGameManager)

    /// handles a drag ended for the subview at index, returns a modified state/game
    func handleDragEnded(
        forIndex index: Int,
        withGestureValue value: DragGesture.Value,
        inManager manager: EasyGameManager)
}

public struct EasyGameSubviewHandleDragDefault: EasyGameSubviewHandleDrag {
    public func handleDragContinued(forIndex index: Int,
                                    withGestureValue value: DragGesture.Value,
                                    inManager manager: EasyGameManager) {
        guard manager.data.subviewSize.width > 0,
              manager.data.subviewSize.height > 0,
              index >= 0, index < manager.game.gridCount
        else {
            return
        }

        if manager.config.dragMovesSubview {
            var data = manager.data
            data.setOffset(value.translation, forIndex: index)
            manager.data = data
        }

        let point = manager.game.pointFor(index: index)
        let currentX: CGFloat = (CGFloat(point.x) * manager.data.subviewSize.width) + value.startLocation.x + value.translation.width
        let currentY: CGFloat = (CGFloat(point.y) * manager.data.subviewSize.height) + value.startLocation.y + value.translation.height
        let coordinate = manager.coordinatePointFor(pixelPoint: CGPoint(x: currentX, y: currentY))

        if coordinate.x != point.x || coordinate.y != point.y {
            var game = manager.game
            game.setState(atPoint: coordinate, to: 2)
            manager.game = game
        }
    }

    public func handleDragEnded(forIndex index: Int,
                                withGestureValue value: DragGesture.Value,
                                inManager manager: EasyGameManager) {
        guard manager.data.subviewSize.width > 0,
              manager.data.subviewSize.height > 0 else {
            return
        }

        var game = manager.game
        game.setState(atIndex: index, to: 2)

        var data = manager.data
        data.setOffset(.zero, forIndex: index)

        let point = game.pointFor(index: index)
        let endX: CGFloat = (CGFloat(point.x) * manager.data.subviewSize.width) + value.startLocation.x + value.translation.width
        let endY: CGFloat = (CGFloat(point.y) * manager.data.subviewSize.height) + value.startLocation.x + value.translation.height

        let coordinate = manager.coordinatePointFor(pixelPoint: CGPoint(x: endX, y: endY))
        game.setState(atPoint: coordinate, to: 3)

        manager.data = data
        manager.game = game
    }
    
    public init() {}
}
