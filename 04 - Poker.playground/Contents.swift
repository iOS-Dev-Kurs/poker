/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
Weil die Karte nur ein Objekt aus Suit bzw Rank sein kann, also zum Beispiel Karo aber nicht gleichzeitig Herz.
*/




import Foundation


enum Suit: Int, CustomStringConvertible {
    case karo, herz, pik, kreuz
    
    var description: String {
        switch self {
        case .karo:
            return "♦️"
        case .herz:
            return "♥️"
        case .pik:
            return "♠️"
        case .kreuz:
            return "♣️"
        }
    }
}

enum Rank: Int, CustomStringConvertible {
    case zwei, drei, vier, fünf, sechs, sieben, acht, neun, zehn, bube, dame, könig, ass
    
    var description: String {
        switch self {
        case .zwei:
            return "2"
        case .drei:
            return "3"
        case .vier:
            return "4"
        case .fünf:
            return "5"
        case .sechs:
            return "6"
        case .sieben:
            return "7"
        case .acht:
            return "8"
        case .neun:
            return "9"
        case .zehn:
            return "10"
        case .bube:
            return "🚶"
        case .dame:
            return "💁"
        case .könig:
            return "👑"
        case .ass:
            return "👌"
        }
    }
}


struct Card: CustomStringConvertible {
    let suit: Suit
    let rank: Rank
    
    var description: String {
        return "\(suit.description)\(rank.description)"
    }
}

extension Card: Equatable {}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}

enum Ranking: Int {
    case highCard, flush, straightFlush, fourOfAKind, fullHouse, twoPair
    
    var description: String {
        switch self {
        case .highCard:
            return "High Card"
        case .flush:
            return "Flush"
        case .straightFlush:
            return "Straight Flush"
        case .fourOfAKind:
            return "Four of a Kind"
        case .fullHouse:
            return "Full House"
        case .twoPair:
            return "Two Pair"
        }
    }
}

struct PokerHand: CustomStringConvertible {
    var cards: [Card]
    
    var description: String {
        return cards.description
    }
    
    var ranking: Ranking {
        for i in 1...4 {
            if (cards[i].suit != cards[i-1].suit) {
                return .highCard
            }
        }
        return .flush
    }
    
    init() {
        cards = [Card(suit: .herz, rank: .dame), Card(suit: .herz, rank: .dame), Card(suit: .herz, rank: .dame), Card(suit: .herz, rank: .dame), Card(suit: .herz, rank: .dame)]
        for n in 0...4 {
            for i in 0..<n {
                let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
                let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
                let rndCard = Card(suit: rndSuit, rank: rndRank)
                cards[n] = rndCard
                if cards[i] == cards[n] {
                    continue
                }
            }
        }
    }
}




//: ## Testing

var rankingCounts = [Ranking : Int]()
let samples = 100
for i in 0..<samples {
    let ranking = PokerHand().ranking
    if rankingCounts[ranking] == nil {
        rankingCounts[ranking] = 1
    } else {
        rankingCounts[ranking]! += 1
    }
}

for (ranking, count) in rankingCounts {
    print("The probability of being dealt a \(ranking.description) is \(Double(count) / Double(samples) * 100)%")
}

