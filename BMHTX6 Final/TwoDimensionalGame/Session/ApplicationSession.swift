import Foundation

// Application Session singleton
class ApplicationSession {
    static let sharedInstance = ApplicationSession()
    
    var persistence: GameSavePersistenceInterface?
    
    private init() {
        if let appStorageUrl = FileManager.default.createDirectoryInUserLibrary(atPath: "TwoDimensionalGame"),
            let persistence = GameSavePersistence(atUrl: appStorageUrl, withDirectoryName: "gameSaves") {
            self.persistence = persistence
        }
    }
}
