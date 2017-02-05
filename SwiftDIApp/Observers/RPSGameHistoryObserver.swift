import SwiftDIHLP

typealias RPSFetchGamesCallback = ([Game]) -> Void
typealias RPSFetchGameCallback = (Game?) -> Void

class RPSGameHistoryObserver: GameHistoryObserver {
    let fetchGamesCallback: RPSFetchGamesCallback?
    let fetchGameCallback: RPSFetchGameCallback?

    init(fetchGamesCallback: @escaping RPSFetchGamesCallback) {
        self.fetchGamesCallback = fetchGamesCallback
        self.fetchGameCallback = nil
    }

    init(fetchGameCallback: @escaping RPSFetchGameCallback) {
        self.fetchGameCallback = fetchGameCallback
        self.fetchGamesCallback = nil
    }

    func fetched(games: [Game]) {
        guard let callback = fetchGamesCallback else { return }
        callback(games)
    }

    func fetched(game: Game?) {
        guard let callback = fetchGameCallback else { return }
        callback(game)
    }
}
