import UIKit
import SwiftDIHLP

class GameHistoryViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView?

    var gameRepository: GameRepository? = nil
    var games: [Game] = []
    var fetchGames: FetchGames?

    override func viewDidLoad() {
        super.viewDidLoad()
        guard let gameRepository = gameRepository else { return }
        let observer = RPSFetchGamesObserver(callback: { (games: [Game]) in
            self.games = games
            DispatchQueue.main.async {
                if let tableView = self.tableView {
                    tableView.reloadData()
                }
            }
        })
        fetchGames = FetchGames(observer: observer, repo: gameRepository)

        displayGames()
    }

    func displayGames() {
        guard let fetchGames = fetchGames else { return }
        fetchGames.execute()
    }
}

extension GameHistoryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return tableView.dequeueReusableCell(withIdentifier: "RPSCell", for: indexPath)
    }
}

extension GameHistoryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let game = games[indexPath.row]
        if let cell = cell as? RPSCell {
            guard let p1Label = cell.p1Label else { return }
            guard let p2Label = cell.p2Label else { return }
            guard let resultLabel = cell.resultLabel else { return }

            p1Label.text = game.p1
            p2Label.text = game.p2
            resultLabel.text = game.result.display()
        }
    }
}
