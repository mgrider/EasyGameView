import SwiftUI

public protocol EasyGameSubviewColorProvider {
    /// A function that returns the color for a given state.
    func colorForState(state: Int?) -> Color
}

/// Create your own `EasyGameViewColorProvider` and set it on the manager
/// to return a color-based state other than random colors.
public struct EasyGameSubviewColorProviderDefault: EasyGameSubviewColorProvider {
    public func colorForState(state: Int?) -> Color {
        return Color(
            red: Double.random(in: 0...1),
            green: Double.random(in: 0...1),
            blue: Double.random(in: 0...1)
        )
    }
    public init() {}
}
