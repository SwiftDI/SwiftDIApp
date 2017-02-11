import SwiftDIHLP

typealias RPSFetchGameCallback = (Game?) -> Void
class RPSFetchGameObserver: FetchGameObserver {
    let callback: RPSFetchGameCallback

    init(callback: @escaping RPSFetchGameCallback) {
        self.callback = callback
    }

    func fetched(game: Game) {
        callback(game)
    }

    func gameNotFound() {
        callback(nil)
    }
}
