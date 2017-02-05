import Quick
import Nimble
import SwiftDIHLP
@testable import SwiftDIApp

class GameResult_displaySpec: QuickSpec {
    override func spec() {
        describe("display") {
            it("returns a display string for each enum value") {
                expect(GameResult.Invalid.display()).to(equal("Invalid Game"))
                expect(GameResult.Tie.display()).to(equal("Tie Game"))
                expect(GameResult.P1Wins.display()).to(equal("Player 1 Wins!"))
                expect(GameResult.P2Wins.display()).to(equal("Player 2 Wins!"))
            }
        }
    }
}
