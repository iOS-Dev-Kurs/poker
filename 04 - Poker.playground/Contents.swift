/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 keine klasse als card <> reference type
*/

import Foundation

enum Suit: Int, CustomStringConvertible {
    case caro = 1
    case herz = 2
    case pik = 3
    case kreuz = 4
    
    var description: String {
        switch self {
    
        case .caro:
            return "\u{2662}"
        case .herz:
            return "\u{2661}"
        case .pik:
            return "\u{2660}"
        case .kreuz:
            return "\u{2663}"
      
        }
    }
}



enum Rank: Int, CustomStringConvertible  {
    case two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10, jack = 11, queen = 12, king = 13, ace = 14
    
    var description: String {
        switch self {
            
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .ten:
            return "10"
        case .jack:
            return "J"
        case .queen:
            return "Q"
        case .king:
            return "K"
        case .ace:
            return "A"
      
        }
    }
}

struct Card: CustomStringConvertible, Equatable {
    
    let suit: Suit
    let rank: Rank
    
    var description: String {
        return suit.description + rank.description
    }
    
    
}

func ==(lhs: Card, rhs: Card) -> Bool {
    
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
    
}



enum Ranking: Int, CustomStringConvertible {
    case highcard = 1, pair = 2, triplet = 3, fullHouse = 4, quadruple = 5, flush = 6, straight = 7, straightFlush = 8
    
    
    var description: String {
        switch self {
            
        case .highcard:
            return "High Card"
        case .pair:
            return "Pair"
        case .triplet:
            return "Triplet"
        case .fullHouse:
            return "Full House"
        case .quadruple:
            return "Vierer, Mann!"
        case .flush:
            return "Krass alter, n Flush!"
        case .straight:
            return "Boa, ne Straße"
        case .straightFlush:
            return "Wahnsinns Typ!"
            
        }
    }
}

struct PokerHand {
    
    var cards: [Card] = []
    
    init() {
        var rndSuit: Suit
        var rndRank: Rank
        var i = 0
        while  i < 5 {
            rndSuit = Suit(rawValue: Int(arc4random_uniform(4)) + 1)!
            rndRank = Rank(rawValue: Int(arc4random_uniform(13)) + 2)!
            let newCard = Card(suit: rndSuit, rank: rndRank)
            if(!cards.contains(newCard)) {
                cards.append(newCard)
                i += 1
            }
        }
   //: cards = cards.sort({$0.rank.rawValue > $1.rank.rawValue})
    }
    

    var description: String {
        var toreturn: String = ""
        for card in cards {
            toreturn += card.description + " "
            
        }
        return toreturn
    
    }
    
    var ranking: Ranking {
        
        for i in 1...4 {
            let reference = cards[i].suit
            let test = cards[i+1].suit
            if test != reference {
                break
                
            }
            return .flush
            
        }
/*          var iqualRank = 1
        
         for i in 1...4 {
            
            let reference = cards[i].rank
            let test = cards[i+1].rank
            if test == reference {
                iqualRank += 1
            }
        }
        
            if iqualRank == 2 {
                return .pair
            }
            if iqualRank == 3 {
                return .triplet
            }
            if iqualRank == 4 {
                return .quadruple
            }
            
*/
        return .highcard
       
        
    }

    
}




//: ## Testing

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

