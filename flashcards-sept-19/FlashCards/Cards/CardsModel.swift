import Foundation

class CardsModel {
    private(set) var deck: Deck
    private var viewedCards: [Card] = []
    private(set) var currentCard: Card?
    
    init(deck: Deck) {
        self.deck = deck
    }
    
    @discardableResult
    func getRandomCard() -> Card? {
        let filteredDeck = deck.cards.filter { (card) -> Bool in
            return !viewedCards.contains(where: {$0 == card})
        }
        currentCard = filteredDeck.randomElement()
        return currentCard
    }
    
    func cardFrontWasShown() {
        if let card = currentCard {
            viewedCards.append(card)
        }
        getRandomCard()
    }
    
}
