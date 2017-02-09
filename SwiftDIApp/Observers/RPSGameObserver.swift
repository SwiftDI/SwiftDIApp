import SwiftDIHLP

typealias GameObserverCallback = () -> Void
class RPSGameObserver: GameObserver {
    let view: NewGameView
    let gameHistoryViewController: GameHistoryViewController

    init(view: NewGameView, gameHistoryViewController: GameHistoryViewController) {
        self.view = view
        self.gameHistoryViewController = gameHistoryViewController
    }

    func p1Wins(game: Game) {
        handleResult(game: game)
    }

    func p2Wins(game: Game) {
        handleResult(game: game)
    }

    func tie(game: Game) {
        handleResult(game: game)
    }

    func invalidGame(game: Game) {
        handleResult(game: game)
    }

    private func handleResult(game: Game) {
        view.display(result: game.result.display())
        gameHistoryViewController.displayGames()
    }
}
