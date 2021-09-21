import SwiftUI

public enum EasyGameSubviewType: Int, Hashable, Codable {

    /// A simple grid where the subview states are represented by background color.
    /// Assign a `EasyGameColorProvider` to the `EasyGameManager` to define custom colors.
    case color

    /// A grid of hexagons with corners pointing up and down.
    case hexUpDown

    /// A grid of `Text` objects.
    /// Assign a `EasyGameTextProvider` to the `EasyGameManager` to define text strings.
    case text
}

/// Light-weight configuration struct. Preferences for display go here.
public struct EasyGameViewConfiguration: Codable {

    /// Whether or not the current drag moves the subview while it's happening.
    /// This only applies if `hasGestureDrag` is true.
    public var dragMovesSubview: Bool

    /// A multiplier for the size of the subview's scale while it's being dragged.
    public var dragScaleMultiplier: CGFloat

    /// The basic type of the grid subviews.
    public var gridType: EasyGameSubviewType

    /// Whether or not you can drag subviews in the grid.
    public var hasGestureDrag: Bool

    /// Whether or not you can tap subviews.
    public var hasGestureTap: Bool

    public init(
        gridType: EasyGameSubviewType = .color,
        hasGestureDrag: Bool = false,
        hasGestureTap: Bool = false,
        dragMovesSubview: Bool = true,
        dragScaleMultiplier: CGFloat = 1.5
    ) {
        self.gridType = gridType
        self.hasGestureDrag = hasGestureDrag
        self.hasGestureTap = hasGestureTap
        self.dragMovesSubview = dragMovesSubview
        self.dragScaleMultiplier = dragScaleMultiplier
    }
}
