import UIKit
import SwiftDIHLP

class NewGameViewController: UIViewController {
    var newGameView: NewGameView { return self.view as! NewGameView }

    @IBAction func playButtonTapped() {
        guard let embeddedViewController = self.childViewControllers.last,
            let gameHistoryViewController = embeddedViewController as? GameHistoryViewController
            else { return }
        let observer = iOSPlayGameObserver(view: newGameView, gameHistoryViewController: gameHistoryViewController)
        UseCases.playGame.execute(p1: newGameView.p1(), p2: newGameView.p2(), observer: observer)
    }
}
