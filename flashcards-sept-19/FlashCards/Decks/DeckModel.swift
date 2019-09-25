import Foundation

class DecksModel {
    private(set) var decks: [Deck]
    
    init() {
        let emojiDeck = DecksModel.createEmojiDeck()!
        
        self.decks = [
            emojiDeck
        ]
    }
    
    func createEmptyDeck(with title: String) {
        decks.append(Deck(id: UUID(), title: title, cards: []))
    }
    
    func removeDeck(at index: Int) {
        decks.remove(at: index)
    }
    
    func replaceExistingDeck(with newDeck: Deck) {
        if let index = decks.firstIndex(where: { $0.id == newDeck.id }) {
            decks[index] = newDeck
        }
    }
    
    static func createEmojiDeck() -> Deck? {
        guard let deckFile = Bundle.main.path(forResource: "decks", ofType: "json") else { return nil }
        
        do {
            guard let jsonData = try String(contentsOfFile: deckFile, encoding: .utf8).data(using: .utf8) else { return nil }
            
            return try JSONDecoder().decode([Deck].self, from: jsonData).first
        } catch {
            return nil
        }
    }
    
}
