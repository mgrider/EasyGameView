import SwiftUI

public struct EasyGameSubview: View {

    /// Text value (for gridType .text)
    @State var stateText = ""

    /// How far the view has been dragged
    @State private var dragOffset = CGSize.zero

    /// Whether this view is currently being dragged or not.
    @State private var isDragging = false

    @State var subviewIndex: Int

    /// The manager instance.
    @ObservedObject var manager: EasyGameManager

    public var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in
                guard manager.config.hasGestureDrag else { return }
                self.isDragging = true
                self.dragOffset = value.translation
            }
            .onEnded { _ in
                guard manager.config.hasGestureDrag else { return }
                withAnimation {
                    self.dragOffset = .zero
                    self.isDragging = false
                }
            }
        switch manager.config.gridType {
        case .color:
            return AnyView(Rectangle()
                .fill(manager.colorForIndex(index: subviewIndex))
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(dragOffset)
                .gesture(dragGesture)
                .zIndex(isDragging ? 2 : 1)
            )
        case .text:
            return AnyView(Text(manager.textForIndex(index: subviewIndex))
                .scaleEffect(isDragging ? 1.5 : 1)
                .offset(dragOffset)
                .gesture(dragGesture)
                .zIndex(isDragging ? 2 : 1)
            )
        }
    }

    public init(subviewIndex: Int,
                manager: EasyGameManager) {
        self.subviewIndex = subviewIndex
        self.manager = manager
    }
}
