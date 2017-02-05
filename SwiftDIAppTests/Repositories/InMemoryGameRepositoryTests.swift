import XCTest
import SwiftDIHLP
@testable import SwiftDIApp

class InMemoryGameRepositoryTests: GameRepositoryTests {
    
    override func setUp() {
        gameRepository = InMemoryGameRepository()
        super.setUp()
    }

}
