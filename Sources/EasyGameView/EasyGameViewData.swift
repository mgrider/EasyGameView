import SwiftUI

/// A struct containing data about our `EasyGameView` and its subviews.
public struct EasyGameViewData: Codable {

    /// An array of `CGSize`s corresponding to the offset of each subview.
    /// Indexes must match those in `EasyGameState`
    public var offsets: [CGSize]

    /// The number of subviews.
    public var subviewCount: Int

    /// The size of an individual subview.
    public var subviewSize: CGSize = .zero

    /// The total size of our game view.
    public var totalSize: CGSize = .zero

    /// This initializer must take a count that corresponds to the `gridCount` property in `EasyGameState`.
    public init(subviewCount: Int) {
        self.subviewCount = subviewCount
        self.offsets = Array(repeating: CGSize.zero, count: subviewCount)
    }

    /// Sets the offset for a given index.
    public mutating func setOffset(_ offset: CGSize, forIndex index: Int) {
        guard index >= 0, index < offsets.count else { return }
        offsets[index] = offset
    }

}
