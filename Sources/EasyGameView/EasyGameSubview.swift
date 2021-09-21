import SwiftUI

public struct EasyGameSubview: View {

    /// How far the view has been dragged
    @State private var dragOffset = CGSize.zero

    /// Whether this view is currently being dragged or not.
    @State private var isDragging = false

    /// This is our index in the EasyGameView grid. We use it to show the correct state.
    @State private var subviewIndex: Int

    /// The manager instance.
    @ObservedObject private var manager: EasyGameManager

    public var body: some View {
        // a tap gesture that tells the manager it's been tapped
        let tapGesture = TapGesture()
            .onEnded { value in
                guard manager.config.hasGestureTap else { return }
                manager.handleTap(atIndex: subviewIndex)
            }
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in
                guard manager.config.hasGestureDrag else { return }
                self.isDragging = true
                manager.handleDragContinued(atIndex: subviewIndex, withGestureValue: value)
            }
            .onEnded { value in
                guard manager.config.hasGestureDrag else { return }
                manager.handleDragEnded(atIndex: subviewIndex, withGestureValue: value)
                self.isDragging = false
            }
        let gestures = dragGesture.exclusively(before: tapGesture)
        switch manager.config.gridType {
        case .color, .hexUpDown:
            return AnyView(Rectangle()
                .fill(manager.stateColor(forIndex: subviewIndex))
                .scaleEffect(isDragging ? manager.config.dragScaleMultiplier : 1)
                .offset(manager.data.offsets[subviewIndex])
                .gesture(gestures)
                .zIndex(isDragging ? 2 : 1)
            )
        case .text:
            return AnyView(Text(manager.stateText(forIndex: subviewIndex))
                .scaleEffect(isDragging ? manager.config.dragScaleMultiplier : 1)
                .offset(manager.data.offsets[subviewIndex])
                .gesture(gestures)
                .zIndex(isDragging ? 2 : 1)
            )
        }
    }

    /// Are we in an even coordinate row?
    func isEvenRow() -> Bool { (subviewIndex / manager.game.gridHeight) % 2 == 0 }

    public init(subviewIndex: Int,
                manager: EasyGameManager) {
        self.subviewIndex = subviewIndex
        self.manager = manager
    }
}
