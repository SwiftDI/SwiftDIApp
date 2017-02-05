import UIKit
import SwiftDIHLP

class NewGameViewController: UIViewController {
    @IBOutlet weak var p1TextField: UITextField?
    @IBOutlet weak var p2TextField: UITextField?
    @IBOutlet weak var gameResultLabel: UILabel?

    let gameRepository = InMemoryGameRepository()
    var observer: RPSGameObserver?

    override func viewDidLoad() {
        super.viewDidLoad()
        observer = RPSGameObserver(callback: {
            (game: Game) in
            guard let gameResultLabel = self.gameResultLabel else { return }
            gameResultLabel.isHidden = false
            gameResultLabel.text = game.result.display()

            if let embeddedViewController = self.childViewControllers.last,
                let gameHistoryViewController = embeddedViewController as? GameHistoryViewController {
                gameHistoryViewController.displayGames()
            }
        })
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "EmbedGameHistoryViewController") {
            guard let gameHistoryViewController = segue.destination as? GameHistoryViewController else { return }
            gameHistoryViewController.gameRepository = gameRepository
        }
    }

    @IBAction func playButtonTapped() {
        guard let p1TextField = p1TextField else { return }
        guard let p2TextField = p2TextField else { return }
        guard let observer = observer else { return }

        if let p1Throw = p1TextField.text,
            let p2Throw = p2TextField.text {
            let p1 = p1Throw.trimmingCharacters(in: .whitespaces)
            let p2 = p2Throw.trimmingCharacters(in: .whitespaces)
            let play = PlayUseCase(p1: p1, p2: p2, observer: observer, repo: gameRepository)
            play.execute()
        }
    }
}
