import UIKit

class NewGameView: UIView {
    @IBOutlet weak var p1TextField: UITextField?
    @IBOutlet weak var p2TextField: UITextField?
    @IBOutlet weak var gameResultLabel: UILabel?

    func p1() -> String {
        return trimmed(textField: p1TextField)
    }

    func p2() -> String {
        return trimmed(textField: p2TextField)
    }

    func display(result: String) {
        guard let gameResultLabel = self.gameResultLabel else { return }
        gameResultLabel.isHidden = false
        gameResultLabel.text = result
    }

    private func trimmed(textField: UITextField?) -> String {
        guard let textField = textField else { return "" }
        if let text = textField.text {
            return text.trimmingCharacters(in: .whitespaces)
        }
        return ""
    }
}
