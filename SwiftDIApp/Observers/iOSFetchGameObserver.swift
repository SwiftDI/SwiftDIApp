import SwiftDIHLP

typealias iOSFetchGameCallback = (Game?) -> Void
class iOSFetchGameObserver: FetchGameObserver {
    let callback: iOSFetchGameCallback

    init(callback: @escaping iOSFetchGameCallback) {
        self.callback = callback
    }

    func fetched(game: Game) {
        callback(game)
    }

    func gameNotFound() {
        callback(nil)
    }
}
