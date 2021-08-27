import Foundation

/// A class that provides observable objects for the `EasyGameView`
class EasyGameManager: ObservableObject {

    @Published var game = EasyGameState()

    @Published var config = EasyGameViewConfiguration()

}
