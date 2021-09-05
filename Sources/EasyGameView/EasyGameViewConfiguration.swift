import SwiftUI

public enum EasyGameSubviewType: Int, Hashable, Codable {

    /// A simple grid where the subview states are represented by background color.
    /// Assign a `EasyGameColorProvider` to the `EasyGameManager` to define custom colors.
    case color

    /// A grid of `Text` objects.
    /// Assign a `EasyGameTextProvider` to the `EasyGameManager` to define text strings.
    case text
}

/// Light-weight configuration struct. Preferences for display go here.
public struct EasyGameViewConfiguration: Codable {

    /// A multiplier for the size of the subview's scale while it's being dragged.
    public var dragScaleMultiplier: CGFloat

    /// The basic type of the grid subviews.
    public var gridType: EasyGameSubviewType

    /// Whether or not you can drag subviews in the grid.
    public var hasGestureDrag: Bool

    /// Whether or not you can tap subviews.
    public var hasGestureTap: Bool

    /// The size of an individual subview.
    public var subviewSize: CGSize = .zero

    public init(
        gridType: EasyGameSubviewType = .color,
        hasGestureDrag: Bool = false,
        hasGestureTap: Bool = false,
        dragScaleMultiplier: CGFloat = 1.5
    ) {
        self.gridType = gridType
        self.hasGestureDrag = hasGestureDrag
        self.hasGestureTap = hasGestureTap
        self.dragScaleMultiplier = dragScaleMultiplier
    }
}
