import SwiftDIHLP

typealias RPSFetchGamesCallback = ([Game]) -> Void
class RPSFetchGamesObserver: FetchGamesObserver {
    let callback: RPSFetchGamesCallback

    init(callback: @escaping RPSFetchGamesCallback) {
        self.callback = callback
    }

    func fetched(games: [Game]) {
        callback(games)
    }
}
