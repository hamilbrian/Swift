import Foundation

struct Deck: Codable {
    let id: UUID
    let title: String
    let cards: [Card]
    
    enum CodingKeys: String, CodingKey {
        case id = "identifier"
        case title = "name"
        case cards
    }
}


