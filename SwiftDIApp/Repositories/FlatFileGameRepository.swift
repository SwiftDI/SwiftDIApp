import SwiftDIHLP
import Foundation

class GameArchiver: Archiver {
    typealias Item = Game
}

class FlatFileGameRepository: GameRepository {
    private let fileURL: URL
    private var games: [Game] = []
    private let archiver: Archiver

    convenience init() {
        self.init(archiver: GameArchiver(), filePath: "/games.txt")
    }

    convenience init(filePath: String) {
        self.init(archiver: GameArchiver(), filePath: filePath)
    }

    init(archiver: Archiver, filePath: String) {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        self.fileURL = URL(fileURLWithPath: documentsDirectory.appending(filePath))
        self.archiver = archiver
    }

    func save(game: Game, completion: SaveGameCompletion) {
        let savedGame = Game(p1: game.p1, p2: game.p2, result: game.result, id: UUID())
        games.append(savedGame)
        archiver.writeToDisk(fileURL: fileURL, items: games)
        completion(savedGame)
    }

    func fetch(completion: FetchGamesCompletion) {
        if let games = archiver.readFromDisk(fileURL: fileURL) as [Game]? {
            self.games = games
            completion(games)
            return
        }
        completion([])
    }

    func fetch(id: UUID, completion: FetchGameCompletion) {
        if let games = archiver.readFromDisk(fileURL: fileURL) as [Game]? {
            self.games = games
            completion(games.filter({$0.id! == id}).first)
        }
    }

    func deleteAll() {
        games = []
        archiver.writeToDisk(fileURL: fileURL, items: games)
    }
}
