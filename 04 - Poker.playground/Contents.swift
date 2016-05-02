/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/


/*
 EURE ANTWORT HIER
*/



import Foundation


enum Suit: Int, CustomStringConvertible {
    case Hearts, Diamonds, Spades, Clubs  //Herz ♥, Karo ♦, Pike ♠, Kreuz ♣
    var description: String {
        switch self {
        case .Hearts: return "♥"
        case .Diamonds: return "♦"
        case .Spades: return "♠"
        case .Clubs: return "♣"
        }
    }
}

enum Rank: Int, CustomStringConvertible {
    case one, two, three, four, five, six, seven, eight, nine, ten, Jack, Queen, King, Ace
    
    var description: String {
        switch self {
        case .one: return "one"
        case .two: return "two"
        case .three: return "three"
        case .four: return "four"
        case .five: return "five"
        case .six: return "six"
        case .seven: return "seven"
        case .eight: return "eight"
        case .nine: return "nine"
        case .ten: return "ten"
        case .Jack: return "jack"
        case .Queen: return "Queen"
        case .King: return "King"
        case .Ace:  return "Ace"
        }
    }
}

struct Card: CustomStringConvertible {
    let suit: Suit
    let rank: Rank
    
    var description: String {
        return "\(suit), \(rank)"
    }
}

extension Card: Equatable {}

func==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}

enum Ranking: Int {
    case highCard, flush
    
    var description: String {
        switch self {
        case .flush:
            return "Flush"
        default:
            return "Highcard"
        }
    }
}


struct PokerHand {
    var cards: [Card] = []
    
    init (){
        while cards.count < 5 {
            let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
            let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
            let rndCard = Card(suit: rndSuit, rank: rndRank)
            if !cards.contains(rndCard) {
                cards.append(rndCard)

            }
        }
       
    }
    
    var description: String {
        var out = ""
        for card in cards {
            out += "\(card.suit) \(card.rank) "
        }
        return out
    }
    
    var ranking: Ranking {
        var hearts = 0
        var diamonds = 0
        var spades = 0
        var clubs = 0
        for card in cards {
            if card.suit == .Hearts {
                hearts += 1
            }
            if card.suit == .Diamonds {
                diamonds += 1
            }
            if card.suit == .Spades {
                spades += 1
            }
            if card.suit == .Clubs {
                clubs += 1
            }
        }
        if hearts >= 4 || diamonds >= 4 || spades >= 4 || clubs >= 4 {
            return .flush
        }
        return .highCard
    }
    
}
var test = PokerHand()
var zwei = PokerHand()
print (zwei.description)
print (test.description)




//: ## Testing

var rankingCounts = [Ranking : Int]()
let samples = 200
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

