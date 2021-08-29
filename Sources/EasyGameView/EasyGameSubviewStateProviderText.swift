import Foundation

public protocol EasyGameSubviewStateProviderText {
    func textForState(state: Int?) -> String
}

public struct EasyGameSubviewStateProviderTextDefault: EasyGameSubviewStateProviderText {
    public func textForState(state: Int?) -> String {
        guard let state = state else { return "?" }
        return "\(String(describing: state))"
    }
    public init() {}
}

