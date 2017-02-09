import Foundation

protocol Archiver {
    func writeToDisk<Item: Serializable>(fileURL: URL, items: [Item])
    func readFromDisk<Item: Serializable>(fileURL: URL) -> [Item]?
}

extension Archiver {
    func writeToDisk<Item: Serializable>(fileURL: URL, items: [Item]) {
        let data = NSKeyedArchiver.archivedData(withRootObject: items.map({$0.serialize()}))
        do {
            try data.write(to: fileURL)
        } catch {
        }
    }

    func readFromDisk<Item: Serializable>(fileURL: URL) -> [Item]? {
        if let serializedItems = NSKeyedUnarchiver.unarchiveObject(withFile: fileURL.path) as? [Serialized] {
            return serializedItems.map({Item(serialized: $0)})
        }
        return nil
    }
}
