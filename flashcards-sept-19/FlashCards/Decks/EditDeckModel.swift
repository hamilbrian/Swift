import Foundation

class EditDeckModel {
    private(set) var deck: Deck
    private(set) var cards: [Card]
    
    init(deck: Deck) {
        self.deck = deck
        self.cards = deck.cards
    }
    
    func addNewCard(withFront front: String, andBack back: String) {
        let card = Card(front: front, back: back)
        cards.append(card)
    }
    
    func editCard() {
        
    }
    
    func removeCard(at index: Int) {
        if index < cards.count {
            cards.remove(at: index)
        }
    }
    
    func saveDeck() {
        self.deck = Deck(id: deck.id, title: deck.title, cards: self.cards)
    }
}
