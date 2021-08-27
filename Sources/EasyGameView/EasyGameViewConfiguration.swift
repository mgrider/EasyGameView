import Foundation

enum EasyGameSubviewType: Int, Hashable, Codable {

    /// A simple grid where the subview states are represented by background color.
    /// Assign a `EasyGameColorProvider` to the `EasyGameManager` to define custom colors.
    case color

    /// A grid of `Text` objects.
    /// Assign a `EasyGameTextProvider` to the `EasyGameManager` to define text strings.
    case text
}

/// Light-weight configuration struct. Preferences for display go here.
struct EasyGameViewConfiguration: Codable {

    /// The basic type of the grid subviews.
    var gridType: EasyGameSubviewType = .color

}
