import SwiftUI

public struct EasyGameHexView: View {

    @StateObject var manager: EasyGameManager

    public var body: some View {
        GeometryReader { proxy in

            let totalWidth = proxy.size.width
            let totalHeight = proxy.size.height

            let numberOfFourths = (manager.game.gridHeight * 3) + 1
            let fourthsHeight = (totalHeight / CGFloat(numberOfFourths))

            let hexHeight: CGFloat = (fourthsHeight * 4)
            let hexWidth: CGFloat = (totalWidth / CGFloat((manager.game.gridWidth * 2) + 1) * 2)

            let gridItems = Array(repeating: GridItem(.fixed(hexWidth), spacing: 0.0), count: manager.game.gridWidth)

            LazyVGrid(columns: gridItems, spacing: 0.0) {
                ForEach(0..<manager.game.gridCount) { idx in
                    EasyGameSubview(
                        subviewIndex: idx,
                        manager: manager
                    )
                    .frame(width: hexWidth, height: hexHeight * 0.75)
                    .clipShape(PolygonShape(sides: 6)
                                .rotation(Angle.degrees(90))
                    )
                    .offset(x: manager.game.indexIsInEvenRow(index: idx) ? -hexWidth/4 : hexWidth/4)
                }
            }
            .frame(width: totalWidth)
            .onAppear(perform: {
                manager.data.totalSize = CGSize(width: totalWidth, height: totalHeight)
                manager.data.subviewSize = CGSize(width: hexWidth, height: hexHeight)
            })

        }
    }

    public init(manager: EasyGameManager = EasyGameManager()) {
        self._manager = StateObject(wrappedValue: manager)
    }
}

struct EasyGameHexView_Previews: PreviewProvider {
    static var previews: some View {
        EasyGameHexView()
    }
}
