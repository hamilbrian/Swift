import Foundation
import struct UIKit.CGFloat

enum Direction {
    case north, east, west, south
}

struct Coordinate {
    let x: Int
    let y: Int
}

struct Location {
    let coordinate: Coordinate
    let allowedDirections: [Direction]
    let event: String?
}

struct Row {
    let locations: [Location]
}

final class GameModel {
    //persistance variables
    private let persistence: GameSavePersistenceInterface?
    private var gameSaves: [gameSave]
    //grid variables
    private var grid = [Row]()
    var currentRowIndex = 0          // start at (x: 0, y: 0)
    var currentLocationIndex = 0
    private let minXYvalue = -20
    private let maxXYvalue = 20
    
    // logic and layout variables
    var directions: [Bool] = [true, true, true, true]
    var limitAlerts: [Bool] = [true, true, true, true]
    var specialEvent = ""
    var normalEvent = "Welcome!"
    var currentPosition = "x: 0 y: 0"
    var red = 255
    var blue = 255
    var green = 255
    
    // the rest
    var gold = 0
    var enemy = ""
    var foundWeapon = ""
    var equippedWeapon = "none"
    var playerHealth = 100
    
    // Added for refernce in GameViewController when calculating distance
    // to animate playerView
    var rowCount: CGFloat { return CGFloat(grid.count) }
    
    init() {
        let persistence = ApplicationSession.sharedInstance.persistence
        self.persistence = persistence
        gameSaves = persistence?.gameSaves ?? []
        loadGame()
    }
}

// MARK: - Public facing methods
extension GameModel {
    func loadGame() {
        if gameSaves.count > 0 {
            currentRowIndex = gameSaves[gameSaves.count - 1].coordinateX
            currentLocationIndex = gameSaves[gameSaves.count - 1].coordianteY
            gold = gameSaves[gameSaves.count - 1].gold
            equippedWeapon = gameSaves[gameSaves.count - 1].weapon
            playerHealth = gameSaves[gameSaves.count - 1].playerHealth
            self.grid = createGameGrid()
            currentPosition = "x: \(currentRowIndex) y: \(currentLocationIndex) "
        }
        else { self.grid = createGameGrid() }
    }
    
    func saveGame() {
        let newGameSave = gameSave(id: "save", gold: gold, weapon: equippedWeapon, coordinateX: currentRowIndex, coordianteY: currentLocationIndex, playerHealth: playerHealth)
        persistence?.save(gameSave: newGameSave)
    }
    
    func fastTravelHome() {
        currentRowIndex = 0
        currentLocationIndex = 0
        directions[0] = true
        directions[1] = true
        directions[2] = true
        directions[3] = true
        limitAlerts[0] = true
        limitAlerts[1] = true
        limitAlerts[2] = true
        limitAlerts[3] = true
        currentPosition = "x: \(currentRowIndex) y: \(currentLocationIndex) "
        normalEvent = "You spent five gold to get home safely"
        gold -= 5
        specialEvent = ""
    }
    
    func currentLocation() -> Location {
        return grid[currentRowIndex].locations[currentLocationIndex]
    }
    
    func equipWeapon() {
        equippedWeapon = foundWeapon
        foundWeapon = ""
        specialEvent = ""
        normalEvent = "You equipped a(n) " + equippedWeapon
        saveGame()
    }
    
    func attack() {
        let chanceToBreakWeapon = Int.random(in: 0 ... 100)
        if chanceToBreakWeapon > 50 {
            equippedWeapon = "none"
            normalEvent = "Your weapon broke!"
        }
        else {
            normalEvent = "You killed the " + enemy
        }
        specialEvent = ""
     
        enemy = ""
    }
    
    func move(direction: Direction) {
        limitAlerts[0] = true
        limitAlerts[1] = true
        limitAlerts[2] = true
        limitAlerts[3] = true
        switch direction {
        case .north:
            currentRowIndex += 1
            if currentRowIndex == maxXYvalue {
                directions[0] = false
                directions[1] = true
                limitAlerts[0] = false
            }
            else {
                directions[0] = true
                directions[1] = true
            }
            normalEvent = "Moved North"
            randomEncounter()
            
            
        case .east:
            currentLocationIndex -= 1
            if currentLocationIndex == minXYvalue {
                directions[2] = false
                directions[3] = true
                limitAlerts[2] = false
            }
            else {
                directions[2] = true
                directions[3] = true
            }
            normalEvent = "Moved East"
            randomEncounter()
            
        case .west:
            currentLocationIndex += 1
            if currentLocationIndex == maxXYvalue {
                directions[3] = false
                directions[2] = true
                limitAlerts[3] = false
            }
            else {
                directions[3] = true
                directions[2] = true
            }
            normalEvent = "Moved West"
            randomEncounter()
            
        case .south:
            currentRowIndex -= 1
            if currentRowIndex == minXYvalue {
                directions[1] = false
                directions[0] = true
                limitAlerts[1] = false
            }
            else {
                directions[1] = true
                directions[0] = true
            }
            normalEvent = "Moved South"
            randomEncounter()
            
        }
        currentPosition = "x: \(currentRowIndex) y: \(currentLocationIndex) "
    }
}

// MARK: - Helper methods for creating grid
extension GameModel {
    private func createGameGrid() -> [Row] {
        let possibleXYValues = Array(minXYvalue...maxXYvalue)
        let gameGrid: [Row] = possibleXYValues.map { yValue in
            let locations: [Location] = possibleXYValues.map { xValue in
                let coordinate = Coordinate(x: xValue, y: yValue)
                let allowedDirections = self.allowedDirections(forCoordinate: coordinate)
                let event = self.event(forCoordinate: coordinate)
                
                return Location(coordinate: coordinate, allowedDirections: allowedDirections, event: event)
            }
            
            return Row(locations: locations)
        }
        
        return gameGrid
    }
    
    private func allowedDirections(forCoordinate coordinate: Coordinate) -> [Direction] {
        var directions = [Direction]()
        
        switch coordinate.y {
        case minXYvalue: directions += [.south]
        case maxXYvalue: directions += [.north]
        default: directions += [.north, .south]
        }
        
        switch coordinate.x {
        case minXYvalue: directions += [.east]
        case maxXYvalue: directions += [.west]
        default: directions += [.east, .west]
        }
        
        return directions
    }
    
    private func event(forCoordinate coordinate: Coordinate) -> String? {
        return nil
    }
    
    private func randomEncounter() {
        // check current position
        if (currentLocationIndex > minXYvalue && currentLocationIndex < maxXYvalue && currentRowIndex > minXYvalue && currentRowIndex < maxXYvalue) {
            // clear the encounter first
            self.red = 255
            self.blue = 255
            self.green = 255
            self.specialEvent = ""
            self.foundWeapon = ""
            self.enemy = ""
            // 50 percent chance of encounter
            let randomNumber = Int.random(in: 0 ... 100)
            if (randomNumber < 30) {
                let encounterChoice = Int.random(in: 1 ... 100)
                switch encounterChoice {
                case 1, 18, 45:
                    self.red = 0
                    self.blue = 150
                    self.green = 150
                    self.specialEvent = "some gold!"
                    gold += Int.random(in: 1 ... 5)
                case 2, 68:
                    self.red = 0
                    self.blue = 25
                    self.green = 0
                    self.specialEvent = "a sword!"
                    self.foundWeapon = "Sword"
                case 4, 10, 78:
                    self.red = 175
                    self.blue = 0
                    self.green = 0
                    self.specialEvent = "an enemy!"
                    self.enemy = "Goblin"
                case 7, 99, 38:
                    self.red = 175
                    self.blue = 0
                    self.green = 0
                    self.specialEvent = "an enemy!"
                    self.enemy = "Kobold"
                case 5:
                    self.red = 128
                    self.blue = 45
                    self.green = 90
                    self.specialEvent = "an axe!"
                    self.foundWeapon = "Axe"
                case 6:
                    self.red = 0
                    self.blue = 99
                    self.green = 128
                    self.specialEvent = "a pile of gold!"
                    gold += Int.random(in: 10 ... 20)
                default:
                    self.red = 250
                    self.blue = 250
                    self.green = 250
                    self.specialEvent = ""
                }
            }
        }
    }
}
