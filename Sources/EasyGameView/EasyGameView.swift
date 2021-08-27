import SwiftUI

struct EasyGameView: View {

    @StateObject var manager = EasyGameManager()

    var body: some View {
        GeometryReader { proxy in

            GeometryReader { proxy in

                let totalWidth = proxy.size.width
                let totalHeight = proxy.size.height
                let cellWidth = totalWidth / CGFloat(manager.game.gridWidth)
                let cellHeight = totalHeight / CGFloat(manager.game.gridHeight)

                let newSize = CGSize(width: cellWidth, height: cellHeight)
                let gridItems = Array(repeating: GridItem(.fixed(newSize.width), spacing: 0.0), count: manager.game.gridCount)

                LazyVGrid(columns: gridItems, spacing: 0.0) {
                    ForEach(0..<manager.game.gridCount) { idx in
                        EasyGameSubview(
                            color: Color(red: Double.random(in: 0...1), green: Double.random(in: 0...1), blue: Double.random(in: 0...1)),
                            manager: manager
                        )
                        .frame(width: newSize.width, height: newSize.height)
                    }
                }
                .frame(width: totalWidth, height: totalHeight)
            }
        }
    }
}

struct EasyGameView_Previews: PreviewProvider {
    static var previews: some View {
        EasyGameView()
    }
}
