import XCTest
import SwiftDIHLP
@testable import SwiftDIApp

class RESTfulGameRepositoryTests: GameRepositoryTests {

    override func setUp() {
        gameRepository = RESTfulGameRepository()
        super.setUp()
    }

}
