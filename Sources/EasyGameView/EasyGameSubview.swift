import SwiftUI

public struct EasyGameSubview: View {

    /// Background color
    @State var color = Color.clear

    /// How far the view has been dragged
    @State private var dragOffset = CGSize.zero

    /// Whether this view is currently being dragged or not.
    @State private var isDragging = false

    /// The manager instance.
    @ObservedObject var manager: EasyGameManager

    public var body: some View {
        // a drag gesture that updates offset and isDragging as it moves around
        let dragGesture = DragGesture()
            .onChanged { value in
                self.isDragging = true
                self.dragOffset = value.translation
            }
            .onEnded { _ in
                withAnimation {
                    self.dragOffset = .zero
                    self.isDragging = false
                }
            }
        return Rectangle()
            .fill(color)
//            .frame(width: 64, height: 64)
            .scaleEffect(isDragging ? 1.5 : 1)
            .offset(dragOffset)
            .gesture(dragGesture)
            .zIndex(isDragging ? 2 : 1)
    }

    public init(color: Color = Color.clear,
                manager: EasyGameManager) {
        self.color = color
        self.manager = manager
    }
}
