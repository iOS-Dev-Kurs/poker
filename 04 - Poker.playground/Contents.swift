/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 EURE ANTWORT HIER
*/





//: ## Testing

import Foundation

enum Rank: Int, CustomStringConvertible {
    
    case two = 2, three, four, five, six, seven, eight, nine, ten, Jack, Queen, King, Ace
    
    var description: String{
        switch self{
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ten: return "10"
        case .Jack: return "J"
        case .Queen: return "Q"
        case .King: return "K"
        case .Ace: return "A"
            
        }
    }
}


 enum Suit: Int, CustomStringConvertible {
    
    case Diamond = 1, Heart, Spate, Club
    
    var description: String{
        switch self{
        case .Diamond: return "\u{2666}"
        case .Heart: return "\u{2665}"
        case .Spate: return "\u{2660}"
        case .Club: return "\u{2663}"
        }
    }
}

enum Ranking: Int {
    case fiveOfaKind, straightFlush, fourOfaKind, fullHouse, flush, straight, threeOfaKind, twoPair, onePain, highCard
}

struct Card: CustomStringConvertible{
    var suit: Suit
    var rank: Rank
    var description: String {
        return suit.description + rank.description
    }
}

extension Card: Equatable {}

func == (lhs: Card, rhs: Card) -> Bool {
    return lhs.rank == rhs.rank && lhs.suit == rhs.suit
}

struct Hand: CustomStringConvertible {
    
    var cards = [Card]()
    
    var description: String {
        var final = ""
        for character in cards.description.characters {
            final.append(character)
        }
        return final
    }
    
    init(numberOfCards: Int){
        
        while cards.count < numberOfCards {
            if let rndSuit = Suit(rawValue: Int(arc4random_uniform(4))), rndRank = Rank(rawValue: Int(arc4random_uniform(13))) {
                let rndCard = Card(suit: rndSuit, rank: rndRank)
                if !self.cards.contains(rndCard) {
                    self.cards.append(rndCard)
                }
            }
            
        }
    }
    
    init(setOfCards: [Card]) {
        self.cards = setOfCards
    }
    
    var isFlush: Bool {
        var flush = true
        for i in (1...self.cards.count.predecessor()){
            if self.cards[i].suit != self.cards[0].suit {
                flush = false
                break
            }
        }
        return flush
    }
    
    var ranking: Ranking {
        if self.isFlush {return Ranking.flush}
        else {return Ranking.highCard}
    }
}

/*
let pik = Suit.Spate
let zwei = Rank.two
let drei = Rank.three


let pikzwei = Card(suit: pik, rank: zwei)
let pikdrei = Card(suit: pik, rank: drei)

let zweierBlatt = Hand(setOfCards: [pikzwei, pikdrei])
print(zweierBlatt.isFlush)
print(zweierBlatt.cards[0].suit)
*/

var rankingCount = [Ranking : Int]()
let samples = 5000
for i in 0...samples {
    let ranking = Hand(numberOfCards: 5).ranking
    if rankingCount[ranking] == nil {
        rankingCount[ranking] = 1
    }
    else {
        rankingCount[ranking]! += 1
    }
}

print(rankingCount)
print(rankingCount[Ranking.flush]!)
print("probability for a flush: \(Double(rankingCount[Ranking.flush]!) / Double(samples))")

/*
let hand = Hand(numberOfCards: 5)
print(hand.description)
print(hand.isFlush)
print(hand.ranking)

*/
