/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 EURE ANTWORT HIER
 1. only need one refernce to Card
 2. Enums eignen sich, weil es bei der Suit- und Rank-Auswahl mehrere Möglichkeiten gibt, welche sich gegenseitig ausschließen
*/

import Foundation

enum Rank: Int, CustomStringConvertible {
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace
    var description: String {
        switch self {
        case .Ace:
            return "Ace"
        case .King:
            return "Jack"
        case .Queen:
            return "Queen"
        case .Jack:
            return "King"
        case .Ten:
            return "Ten"
        case .Nine:
            return "Nine"
        case .Eight:
            return "Eight"
        case .Seven:
            return "Seven"
        case .Six:
            return "Six"
        case .Five:
            return "Five"
        case .Four:
            return "Four"
        case .Three:
            return "Three"
        case .Two:
            return "Two"
        }
    }
}

enum Suit: Int, CustomStringConvertible {
    case Spades, Hearts, Diamonds, Clubs
    var description: String {
        switch self {
        case .Spades:
            return "U+2660"
        case .Hearts:
            return "U+2665"
        case .Diamonds:
            return "U+2666"
        case .Clubs:
            return "U+2663"
        }
    }
}

struct Card: CustomStringConvertible {
    let suit: Suit
    let rank: Rank
    var description: String {
        return "\(Rank.self) + \(Suit.self)"
    }
}

struct Pokerhand {
    let cards: [Card]
    var description: String {
        return "\(Rank.self) + \(Suit.self)"
    }
}

let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
let rndCard = Card(suit: rndSuit, rank: rndRank)
//: ## Testing
/*
var rankingCounts = [Ranking : Int]()
let samples = 100
for i in 0...samples {
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
*/
