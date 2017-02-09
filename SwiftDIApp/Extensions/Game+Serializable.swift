import SwiftDIHLP

extension Game: Serializable {
    struct Key {
        static let ID = "id"
        static let P1 = "p1"
        static let P2 = "p2"
        static let Result = "result"
    }

    init(serialized: Serialized) {
        if let p1 = serialized[Key.P1] as? String,
            let p2 = serialized[Key.P2] as? String,
            let resultString = serialized[Key.Result] as? String,
            let result = GameResult(rawValue: resultString),
            let id = serialized[Key.ID] as? String {
            self.init(p1: p1, p2: p2, result: result, id: UUID(uuidString: id)!)
        } else if let p1 = serialized[Key.P1] as? String,
            let p2 = serialized[Key.P2] as? String,
            let resultString = serialized[Key.Result] as? String,
            let result = GameResult(rawValue: resultString) {
            self.init(p1: p1, p2: p2, result: result)
        } else {
            self.init(p1: "", p2: "", result: .Invalid)
        }
    }

    func serialize() -> Serialized {
        if let id = id {
            return [
                Key.P1: p1 as AnyObject,
                Key.P2: p2 as AnyObject,
                Key.Result: result.rawValue as AnyObject,
                Key.ID: id.uuidString as AnyObject
            ]
        } else {
            return [
                Key.P1: p1 as AnyObject,
                Key.P2: p2 as AnyObject,
                Key.Result: result.rawValue as AnyObject
            ]
        }
    }
}

