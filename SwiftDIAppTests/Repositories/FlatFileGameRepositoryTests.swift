import XCTest
import SwiftDIHLP
@testable import SwiftDIApp

class FlatFileGameRepositoryTests: GameRepositoryTests {

    override func setUp() {
        gameRepository = FlatFileGameRepository(filePath: "/test_games.txt")
        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
        guard let gameRepository = gameRepository else { return }
        gameRepository.deleteAll()
    }

}
