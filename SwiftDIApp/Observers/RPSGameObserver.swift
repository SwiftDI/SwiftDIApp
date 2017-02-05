import SwiftDIHLP

typealias GameObserverCallback = (Game) -> Void
class RPSGameObserver: GameObserver {
    let callback: GameObserverCallback

    init(callback: @escaping GameObserverCallback) {
        self.callback = callback
    }

    func p1Wins(game: Game) {
        callback(game)
    }

    func p2Wins(game: Game) {
        callback(game)
    }

    func tie(game: Game) {
        callback(game)
    }

    func invalidGame(game: Game) {
        callback(game)
    }
}
