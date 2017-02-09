import UIKit
import SwiftDIHLP

class NewGameViewController: UIViewController {
    var newGameView: NewGameView { return self.view as! NewGameView }
    let gameRepository = InMemoryGameRepository()

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EmbedGameHistoryViewController") {
            guard let gameHistoryViewController = segue.destination as? GameHistoryViewController else { return }
            gameHistoryViewController.gameRepository = gameRepository
        }
    }

    @IBAction func playButtonTapped() {
        guard let embeddedViewController = self.childViewControllers.last,
            let gameHistoryViewController = embeddedViewController as? GameHistoryViewController
            else { return }
        let play = PlayUseCase(p1: newGameView.p1(),
                               p2: newGameView.p2(),
                               observer: RPSGameObserver(view: newGameView,
                                                         gameHistoryViewController: gameHistoryViewController),
                               repo: gameRepository)
        play.execute()
    }
}
