import Foundation

struct Card: Codable, Equatable {
    let front: String
    let back: String
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.front == rhs.front &&
        lhs.back == rhs.back
}
