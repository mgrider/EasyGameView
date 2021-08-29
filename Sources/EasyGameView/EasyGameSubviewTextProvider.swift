import Foundation

public protocol EasyGameSubviewTextProvider {
    func textForState(state: Int?) -> String
}

public struct EasyGameSubviewTextProviderDefault: EasyGameSubviewTextProvider {
    public func textForState(state: Int?) -> String {
        guard let state = state else { return "?" }
        return "\(String(describing: state))"
    }
    public init() {}
}

