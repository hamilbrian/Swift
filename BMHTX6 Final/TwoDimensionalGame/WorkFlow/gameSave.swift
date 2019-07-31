import Foundation

struct gameSave: Codable {
    let id: String
    var gold: Int
    var weapon: String
    var coordinateX: Int
    var coordianteY: Int
    var playerHealth: Int
}

extension gameSave {
    static var defaultGameSave: gameSave {
        return gameSave(id: "save", gold: 0, weapon: "", coordinateX: 0, coordianteY: 0, playerHealth: 100)
    }
}
