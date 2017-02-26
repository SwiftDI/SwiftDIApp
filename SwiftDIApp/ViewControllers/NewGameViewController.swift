import UIKit
import SwiftDIHLP

class NewGameViewController: UIViewController {
    var newGameView: NewGameView { return self.view as! NewGameView }
    let gameRepository = RESTfulGameRepository()
    var playGame: PlayGame?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let embeddedViewController = self.childViewControllers.last,
              let gameHistoryViewController = embeddedViewController as? GameHistoryViewController
                else { return }
        let observer = iOSPlayGameObserver(view: newGameView, gameHistoryViewController: gameHistoryViewController)
        playGame = PlayGame(observer: observer, repo: gameRepository)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EmbedGameHistoryViewController") {
            guard let gameHistoryViewController = segue.destination as? GameHistoryViewController else { return }
            gameHistoryViewController.gameRepository = gameRepository
        }
    }

    @IBAction func playButtonTapped() {
        guard let playGame = playGame else { return }
        playGame.execute(p1: newGameView.p1(), p2: newGameView.p2())
    }
}
