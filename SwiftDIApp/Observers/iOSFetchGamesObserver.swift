import SwiftDIHLP

typealias iOSFetchGamesCallback = ([Game]) -> Void
class iOSFetchGamesObserver: FetchGamesObserver {
    let callback: iOSFetchGamesCallback

    init(callback: @escaping iOSFetchGamesCallback) {
        self.callback = callback
    }

    func fetched(games: [Game]) {
        callback(games)
    }
}
