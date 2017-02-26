import SwiftDIHLP

struct Config {
    static let gameRepository: GameRepository = RESTfulGameRepository.shared
}
