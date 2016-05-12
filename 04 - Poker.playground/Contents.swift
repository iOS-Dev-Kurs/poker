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
    case highcard = 1, pair = 2, twoPair = 3, triplet = 4, fullHouse = 5, quadruple = 6, flush = 7, straight = 8, straightFlush = 9, royalFlush = 10
    
    
    var description: String {
        switch self {
            
        case .highcard:
            return "High Card"
        case .pair:
            return "Pair"
        case .twoPair:
            return "2 Pairs"
        case .triplet:
            return "Three of a kind"
        case .fullHouse:
            return "Full House"
        case .quadruple:
            return "Four of a kind"
        case .flush:
            return "Krass alter, n Flush!"
        case .straight:
            return "Boa, ne Straße"
        case .straightFlush:
            return "Straigh Flush! Du Wahnsinns Typ!"
        case .royalFlush:
            return "Royal Flush"
            
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
        cards = cards.sort({$0.rank.rawValue > $1.rank.rawValue})
    }
    

    var description: String {
        var toreturn: String = ""
        for card in cards {
            toreturn += card.description + " "
            
        }
        return toreturn
    
    }
    
    var ranking: Ranking {
        
        
        if (HasStraight(cards) && HasFlush(cards).hasFlush && HasFlush(cards).highestRank.rawValue == 14) {
            return .royalFlush
        }
            
        else if (HasStraight(cards) && HasFlush(cards).hasFlush) {
            return .straightFlush
        }
        else if HasPair(cards).hasVierling {
            return .quadruple
        }
            
        else if (HasPair(cards).hasSecondPair && HasPair(cards).hasTriple && (HasPair(cards).highPairRank != HasPair(cards).highTripleRank || HasPair(cards).secondPairRank != HasPair(cards).highTripleRank )) {
            return .fullHouse
        }
        else if HasStraight(cards) {
            return .straight
        }
        
        else if HasFlush(cards).hasFlush {
            return .flush
            }
            
        else if HasPair(cards).hasTriple {
            return .triplet
        }
            
        else if HasPair(cards).hasSecondPair {
            return .twoPair
        }
        
        else if HasPair(cards).hasPair {
            return .pair
        }
        
    
        else {
           return .highcard
        }
        
    }
    
    
}




func HasFlush (cards : [Card]) -> (hasFlush: Bool, highestRank: Rank) {
    var hasFlush: Bool = false
    let reference = cards[0].suit
    let highestCard = cards[0].rank
    
    for i in 1...4 {
        
        
        if cards[i].suit != reference {
        
            break
            
        }
        if i==4 { hasFlush = true }
    
    }
    
    return (hasFlush, highestCard)
}

func HasPair (cards : [Card]) -> (hasPair: Bool, hasSecondPair: Bool, hasTriple: Bool, hasVierling: Bool, highPairRank: Rank?, secondPairRank: Rank?, highTripleRank: Rank?) {

    var hasPair: Bool = false
    var hasSecondPair: Bool = false
    var hasTriple: Bool = false
    var hasVierling: Bool = false
    var highPairRank: Rank? = nil
    var highTripleRank: Rank? = nil
    var secondPairRank: Rank? = nil
    
    for i in 1...4 {
        if cards[i].rank == cards[i-1].rank {
            if !hasPair {
                // finde erstes Pärchen
                hasPair = true
                highPairRank = cards[i].rank
            }
            else { // 2tes paar oder drilling oder vierling
                hasSecondPair = true
                secondPairRank = cards[i].rank
            }
            if (i < 4 && cards[i + 1].rank == cards[i].rank) { //Drilling gefunden
                hasTriple = true
                highTripleRank = cards[i].rank
            }
            if(i < 3 && cards[i + 1].rank == cards[i].rank && cards[i + 2].rank == cards[i].rank) { // Vierling gefunden
                hasVierling = true
            }
        }
    
    }
    return (hasPair, hasSecondPair, hasTriple, hasVierling, highPairRank, secondPairRank, highTripleRank)
}


func HasStraight (cards : [Card]) -> Bool {
    var hasStraight: Bool = false
    var i: Int = 1
    while i < 5 {
        if 1 + cards[i].rank.rawValue ==  cards[i-1].rank.rawValue {
            i += 1
            
        } else {
            break
            
        }
        if i == 4 {hasStraight = true}
    }
    return hasStraight
}

/* let hand = PokerHand()
print(hand.cards[0].rank.rawValue)
print(hand.cards[1].rank.rawValue)
print(hand.cards[2].rank.rawValue)
 */
//: ## Testing

var rankingCounts = [Ranking : Int]()
let samples = 10
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
