//
//  GameModel.swift
//  Match Game Brian Hamil
//
//  Created by user159467 on 10/2/19.
//  Copyright © 2019 user159467. All rights reserved.
//

import Foundation

protocol GameModelDelegate: class {
}

final class GameModel {
    
    // delegation
    private weak var delegate: GameModelDelegate?
    
    //persistance variables
    private let persistence: GameSavePersistenceInterface?
    private var gameSaves: [gameSave]
    
    // model variables
    var deck: Deck!
    var gridSize = 4
    var deckSize = 2
    var puzzleSize = 2
    var cards: [Card] = []
    var lastPicked = IndexPath.init()
    
    // default card
    let defaultCard = Card.init(front: "Front", back: "Back")
    
    init(delegate: GameModelDelegate) {
        self.delegate = delegate
        let persistence = ApplicationSession.sharedInstance.persistence
        self.persistence = persistence
        gameSaves = persistence?.gameSaves ?? []
        loadGame()
    }
    
    func loadGame() {
        if gameSaves.count > 0 {
            puzzleSize = gameSaves[0].puzzleSize
        }
        else { puzzleSize = 2 }
    }
    
    func saveGame() {
        let newGameSave = gameSave(id: "save", puzzleSize: puzzleSize)
        persistence?.save(gameSave: newGameSave)
    }
    
    func setPuzzleSize(size: Int) {
        puzzleSize = size
        gridSize = puzzleSize * puzzleSize
        deckSize = gridSize/2
        makeDeck()
        saveGame()
    }
    
    func makeDeck() {
        deck = createEmojiDeck()
        var index = deckSize
        cards.removeAll()
        while index > 0 {
            let tempCard = deck.cards.randomElement() ?? defaultCard
            if cards.contains(tempCard) == false {
                cards.append(tempCard)
                index -= 1
            }
        }
        cards.append(contentsOf: cards)
    }
    
    func compareCards(card1: Card, card2: Card) -> Bool {
        
        if card1.front == card2.front {
            return true
        }
        else {
            lastPicked = IndexPath.init()
            return false
        }
    }
    
    func createEmojiDeck() -> Deck? {
        
        guard let deckFile = Bundle.main.path(forResource: "Emoji", ofType: "json") else { return nil }
        
        do {
            guard let jsonData = try String(contentsOfFile: deckFile, encoding: .utf8).data(using: .utf8) else { return nil }
            
            return try JSONDecoder().decode([Deck].self, from: jsonData).first
        } catch {
            print(error)
            return nil
        }
    }
}
