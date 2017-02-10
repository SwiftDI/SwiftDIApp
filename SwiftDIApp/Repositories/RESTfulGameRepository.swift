import SwiftDIHLP
import Foundation

class RESTfulGameRepository: GameRepository {
    private let urlSession: URLSession

    convenience init() {
        self.init(urlSession: URLSession.shared)
    }

    init(urlSession: URLSession) {
        self.urlSession = urlSession
    }

    func save(game: Game, completion: @escaping SaveGameCompletion) {
        guard let request = saveRequest(game: game) else { return }
        perform(request: request) { (data: Data?, error: Error?) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let serialized = json as? Serialized {
                        completion(Game(serialized: serialized))
                    }
                } catch {}
            }
        }
    }

    func fetch(completion: @escaping FetchGamesCompletion) {
        guard let request = fetchGamesRequest() else { return }
        perform(request: request) { (data: Data?, error: Error?) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data)
                    if let serializeds = json as? [Serialized] {
                        var games: [Game] = []
                        for serialized in serializeds {
                            games.append(Game(serialized: serialized))
                        }
                        completion(games)
                    }
                } catch {}
            }
        }
    }

    func fetch(id: UUID, completion: @escaping FetchGameCompletion) {
        guard let request = fetchGameRequest(uuid: id) else { return }
        perform(request: request) { (data: Data?, error: Error?) in
            if let data = data {
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                    if let serialized = json as? Serialized {
                        completion(Game(serialized: serialized))
                    }
                } catch {
                    completion(nil)
                }
            }
        }
    }

    func deleteAll() {
        guard let request = deleteAllRequest() else { return }
        perform(request: request) { (data: Data?, error: Error?) in }
    }

    private func saveRequest(game: Game) -> URLRequest? {
        if let url = URL(string: "http://localhost:8090/games") {
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: game.serialize())
            } catch {}
            return request
        }
        return nil
    }

    private func fetchGamesRequest() -> URLRequest? {
        if let url = URL(string: "http://localhost:8090/games") {
            return URLRequest(url: url)
        }
        return nil
    }

    private func fetchGameRequest(uuid: UUID) -> URLRequest? {
        if let url = URL(string: "http://localhost:8090/games/\(uuid.uuidString)") {
            return URLRequest(url: url)
        }
        return nil
    }

    private func deleteAllRequest() -> URLRequest? {
        if let url = URL(string: "http://localhost:8090/games") {
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"
            return request
        }
        return nil
    }

    private func perform(request: URLRequest, completion: @escaping (Data?, Error?) -> Void) {
        let dataTask = urlSession.dataTask(with: request) {
            data, response, error in
            completion(data, error)
        }
        dataTask.resume()
    }
}
