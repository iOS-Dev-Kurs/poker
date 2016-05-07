/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
//    Suit und Rank sind als Zahlen virtueller Spielkarten einfache Aufzählungen (also Enumerations). Deswegen wäre es unnötige Mehrarbeit für jede Karte eine extra Variable anzulegen.
//    Für die Spielkarten selber wird ein Struct erstellt, was als Argumente die Enums übernimmt, die bereits die Kartenwerte enthalten.
//Durch die Klasse Struct wird ein konkretes "Kartenspiel" erstellt, welches im weiteren verwendet werden kann. Durch die Enums werden so etwa auch Vergleiche zwischen den einzelnen Karten und Kombinationen möglich.



//: ## Testing
// CustomStringConvertible Protocol kann nicht ausgeführt werden und meldet Error

import Foundation
import UIKit

enum Ranks: Int, CustomStringConvertible {
    case Ass = 1, König, Dame, Bube, Zehn, Neun, Acht, Sieben, Sechs, Fünf, Vier, Drei, Zwei
    
    var description: String
    {
        switch self
        {
            case Ass:
                return "Ass"
            case König:
                return "König"
            case Dame:
                return "Dame"
            case Bube:
                return "Bube"
            case Zehn:
                return "10"
            case Neun:
                return "9"
            case Acht:
                return "8"
            case Sieben:
                return "7"
            case Sechs:
                return "6"
            case Fünf:
                return "5"
            case Vier:
                return "4"
            case Drei:
                return "3"
            case Zwei:
                return "2"
            }
    }
}

// CustomStringConvertible Protocol kann nicht ausgeführt werden und meldet Error

enum Suits: Int, CustomStringConvertible {
    case Karo = 1
    case Herz
    case Kreuz
    case Pik
    
    var description: String
    {
        switch self {
            case Karo:
                return "♢"
            case Herz:
                return "♡"
            case Kreuz:
                return "♧"
            case Pik:
                return "♤"
        }
    }
}


struct Card: CustomStringConvertible {
    
    var rank : Ranks
    var suit : Suits
    
    init (rank: Ranks, suit: Suits) {
        self.rank = rank
        self.suit = suit
    }
    
    var description: String
    {
        return "rank: \(rank), suit: \(suit)"
    }
    
    static func createCard() -> Card {
        let rndRank = Ranks(rawValue: Int(arc4random_uniform(13)))!
        let rndSuit = Suits(rawValue: Int(arc4random_uniform(4)))!
        let rndCard = Card(rank: rndRank, suit: rndSuit)
        
        let strgCard = String(rndCard)
        print("Your Card: \(strgCard)")
        return rndCard
    }
}

extension Card : Equatable {}
func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}


struct PokerHand {
    
    var cards : [Card]
    
    init (cards: [Card]) {
        self.cards = cards
    }
    
    static func createPokerHand() -> [Card] {
        var cards = [Card]()
        let card = Card.createCard()
        cards.append(card)
        if cards.count < 5 {
            print("\(cards.count)")
            for index in cards.indices {
                print("for")
                let newCard = Card.createCard()
                while newCard != cards[index] {
                    cards.append(card)
                }
            }
        } else {
            print("No Way")
        }
        return cards
    }
    
}

let fiveCards = [Card]()
PokerHand.init(cards: fiveCards)
let pokerHand = PokerHand.createPokerHand()
print("Your Hand: \(pokerHand)")

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
