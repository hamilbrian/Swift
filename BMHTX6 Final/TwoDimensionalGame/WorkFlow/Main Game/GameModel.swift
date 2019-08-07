import Foundation
import struct UIKit.CGFloat

protocol GameModelDelegate: class {
    func updateUIView()
    func animateMovement(direction: Direction)
}

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
    
    // delegation
    private weak var delegate: GameModelDelegate?
    
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
    var limitAlerts: [Bool] = [false, false, false, false]
    var specialEvent = ""
    var normalEvent = "Welcome!"
    var currentPosition = "x: 0 y: 0"
    var red = 255 / 255
    var blue = 255 / 255
    var green = 255 / 255
    
    // the rest
    var gold = 0
    var enemy = ""
    var foundWeapon = ""
    var equippedWeapon = ""
    var playerHealth = 100
    
    // Added for reference in GameViewController when calculating distance to animate playerView
    var rowCount: CGFloat { return CGFloat(grid.count) }
    
    init(delegate: GameModelDelegate) {
        self.delegate = delegate
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
            self.grid = createGameGrid()
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
        playerHealth = 100
        
        for index in 0 ..< directions.count {
            directions[index] = true
        }
        
        for index in 0 ..< limitAlerts.count {
            limitAlerts[index] = false
        }
        
        currentPosition = "x: \(currentRowIndex) y: \(currentLocationIndex) "
        normalEvent = "You got home safely."
        gold -= 5
        specialEvent = ""
        enemy = ""
        saveGame()
        delegate?.updateUIView()
    }
    
    func currentLocation() -> Location {
        return grid[currentRowIndex].locations[currentLocationIndex]
    }
    
    func equipWeapon() {
        equippedWeapon = foundWeapon
        foundWeapon = ""
        specialEvent = ""
        normalEvent = "You equipped a(n) " + equippedWeapon + "."
        saveGame()
    }
    
    func attack() {
        saveGame()
    }
    
    func move(direction: Direction) {
        
        for index in 0 ..< limitAlerts.count {
            limitAlerts[index] = false
        }
        
        switch direction {
        case .north:
            currentRowIndex += 1
            if currentRowIndex == maxXYvalue {
                directions[0] = false
                directions[1] = true
                limitAlerts[0] = true
                normalEvent = "Northern Edge."
            }
            else {
                directions[0] = true
                directions[1] = true
                delegate?.animateMovement(direction: .north)
                normalEvent = "Moved North."
                randomEncounter()
            }
            
        case .east:
            currentLocationIndex -= 1
            if currentLocationIndex == minXYvalue {
                directions[2] = false
                directions[3] = true
                limitAlerts[2] = true
                normalEvent = "Eastern Edge."
            }
            else {
                directions[2] = true
                directions[3] = true
                delegate?.animateMovement(direction: .east)
                normalEvent = "Moved East."
                randomEncounter()
            }
            
        case .west:
            currentLocationIndex += 1
            if currentLocationIndex == maxXYvalue {
                directions[3] = false
                directions[2] = true
                limitAlerts[3] = true
                normalEvent = "Western Edge."
            }
            else {
                directions[3] = true
                directions[2] = true
                delegate?.animateMovement(direction: .west)
                normalEvent = "Moved West."
                randomEncounter()
            }
            
        case .south:
            currentRowIndex -= 1
            if currentRowIndex == minXYvalue {
                directions[1] = false
                directions[0] = true
                limitAlerts[1] = true
                normalEvent = "Southern Edge."
            }
            else {
                directions[1] = true
                directions[0] = true
                delegate?.animateMovement(direction: .south)
                normalEvent = "Moved South."
                randomEncounter()
            }
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
    
    private func event(forCoordinate coordinate: Coordinate) -> String? { return nil }
    
    private func randomEncounter() {
        
        // check current position
        if (currentLocationIndex > minXYvalue && currentLocationIndex < maxXYvalue && currentRowIndex > minXYvalue && currentRowIndex < maxXYvalue) {
            
            // clear the encounter first
            self.red = 255 / 255
            self.blue = 255 / 255
            self.green = 255 / 255
            self.specialEvent = ""
            self.foundWeapon = ""
            self.enemy = ""
            
            // 30 percent chance of encounter
            let randomNumber = Int.random(in: 0 ... 100)
            
            if (randomNumber < 101) {
                
                let encounterChoice = Int.random(in: 1 ... 100)
                
                switch encounterChoice {
                case 1:
                    self.red = 0
                    self.blue = 150 / 255
                    self.green = 150 / 255
                    self.specialEvent = "some gold!"
                    gold += Int.random(in: 1 ... 5)
                case 2, 68:
                    self.red = 0
                    self.blue = 25 / 255
                    self.green = 0
                    self.specialEvent = "a sword!"
                    self.foundWeapon = "Sword"
                case 4, 10, 78:
                    self.red = 175 / 255
                    self.blue = 0
                    self.green = 0
                    self.specialEvent = "an enemy!"
                    self.enemy = "Goblin"
                case 7, 99, 38:
                    self.red = 175 / 255
                    self.blue = 0
                    self.green = 0
                    self.specialEvent = "an enemy!"
                    self.enemy = "Kobold"
                case 5, 45:
                    self.red = 128 / 255
                    self.blue = 45 / 255
                    self.green = 90 / 255
                    self.specialEvent = "an axe!"
                    self.foundWeapon = "Axe"
                case 6:
                    self.red = 0
                    self.blue = 99 / 255
                    self.green = 128 / 255
                    self.specialEvent = "a pile of gold!"
                    gold += Int.random(in: 10 ... 20)
                case 11, 43:
                    self.red = 128 / 255
                    self.blue = 45 / 255
                    self.green = 90 / 255
                    self.specialEvent = "a spear!"
                    self.foundWeapon = "Spear"
                default:
                    self.red = 250 / 255
                    self.blue = 250 / 255
                    self.green = 250 / 255
                    self.specialEvent = ""
                }
            }
        }
    }
}

extension GameModel: BattleModelDelegate {
    
    func updateUI() {
        // don't need to change anything here
    }
    
    func flee(playerWeapon: String, playerHealth: Int) {
        normalEvent = "You ran like a coward!"
        self.playerHealth = playerHealth
        self.equippedWeapon = playerWeapon
        enemy = ""
        specialEvent = ""
        if gold >= 10 {
            gold -= 10
        }
        
        else {
            gold = 0
        }
        
        saveGame()
        
        delegate?.updateUIView()
    }
    
    func victory(playerHealth: Int) {
        self.playerHealth = playerHealth
        normalEvent = "You killed the " + enemy + "!"
        enemy = ""
        specialEvent = ""
        saveGame()
        delegate?.updateUIView()
    }
    
    func death() {
        normalEvent = "You died!"
        playerHealth = 100
        enemy = ""
        specialEvent = ""
        equippedWeapon = ""
        
        if gold >= 20 {
            gold -= 20
        }
        else {
            gold = 0
        }
        currentRowIndex = 0
        currentLocationIndex = 0
        
        for index in 0 ..< directions.count {
            directions[index] = true
        }
        
        for index in 0 ..< limitAlerts.count {
            limitAlerts[index] = false
        }
        
        currentPosition = "x: \(currentRowIndex) y: \(currentLocationIndex) "
        saveGame()
        delegate?.updateUIView()
    }
}
