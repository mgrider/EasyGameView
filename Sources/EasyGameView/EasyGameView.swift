import SwiftUI

public struct EasyGameView: View {

    @StateObject var manager = EasyGameManager()

    public var body: some View {
        GeometryReader { proxy in

            let totalWidth = proxy.size.width
            let totalHeight = proxy.size.height
            let cellWidth = totalWidth / CGFloat(manager.game.gridWidth)
            let cellHeight = totalHeight / CGFloat(manager.game.gridHeight)

            let gridItems = Array(repeating: GridItem(.fixed(cellWidth), spacing: 0.0), count: manager.game.gridWidth)

            LazyVGrid(columns: gridItems, spacing: 0.0) {
                ForEach(0..<manager.game.gridCount) { idx in
                    EasyGameSubview(
                        color: Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)),
                        manager: manager
                    )
                    .frame(width: cellWidth, height: cellHeight)
                }
            }
            .frame(width: totalWidth)

        }
    }

    public init() {}
}

struct EasyGameView_Previews: PreviewProvider {
    static var previews: some View {
        EasyGameView()
    }
}
