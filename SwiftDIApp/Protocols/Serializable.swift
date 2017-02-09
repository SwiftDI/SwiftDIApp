typealias Serialized = [String: AnyObject]
protocol Serializable {
    func serialize() -> Serialized
    init(serialized: Serialized)
}
