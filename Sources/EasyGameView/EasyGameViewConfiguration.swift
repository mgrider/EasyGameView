import Foundation

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

    /// The basic type of the grid subviews.
    var gridType: EasyGameSubviewType

    /// Whether or not you can drag subviews in the grid.
    var hasGestureDrag: Bool

    public init(
        gridType: EasyGameSubviewType = .color,
        hasGestureDrag: Bool = false
    ) {
        self.gridType = gridType
        self.hasGestureDrag = hasGestureDrag
    }
}
