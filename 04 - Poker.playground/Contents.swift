/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
import UIKit

enum Rank: Int, CustomStringConvertible {
    case two = 1, three = 2, four = 3, five = 4, six = 5, seven = 6, eight = 7, nine = 8, ten = 9, bube = 10, dame = 11, koenig = 12, ass = 13
    var description: String {
        switch self{
        case .ass: return "A"
        case .koenig: return "K"
        case .dame: return "D"
        case .bube: return "J"
        case .ten: return "10"
        case .nine: return "9"
        case .eight: return "8"
        case .seven: return "7"
        case .six: return "6"
        case .five: return "5"
        case .four: return "4"
        case .three: return "3"
        case .two: return "2"
        }
    }
}


enum Suit: Int, CustomStringConvertible {
    case Karo = 1, Herz = 2, Pik = 3, Kreuz = 4
    var description: String{
        switch self{
        case .Karo: return "\u{2666}"
        case .Herz: return "\u{2665}"
        case .Pik: return "\u{2660}"
        case .Kreuz: return "\u{2663}"
        }
    }
}

/*Wieso struct? Weil Karten statische Dinge sind*/
struct Card: CustomStringConvertible {
    /*Wieso enum? Weil sich die Faelle gegenseitig ausschließen und nur eine Karte eine Farbe und einen Rang haben kann */
    
    let suit: Suit
    let rank: Rank
    
    var description: String{
    return "\(suit) \(rank)"
    }
    
}

extension Card: Equatable{}
func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}

struct PokerHand{
    let cards: [Card]
    
    init(){
        var p1 = Card(suit: Suit(rawValue: 1)!, rank: Rank(rawValue: 1)!)
        var p2 = Card(suit: Suit(rawValue: 1)!, rank: Rank(rawValue: 1)!)
        var p3 = Card(suit: Suit(rawValue: 1)!, rank: Rank(rawValue: 1)!)
        var p4 = Card(suit: Suit(rawValue: 1)!, rank: Rank(rawValue: 1)!)
        var p5 = Card(suit: Suit(rawValue: 1)!, rank: Rank(rawValue: 1)!)
        while p1==p2 || p1==p3 || p1==p4 || p1==p5 || p2==p3 || p2==p4 || p2==p5 || p3==p4 || p3==p5 || p4==p5{
            var rndSuit = Suit(rawValue: Int(arc4random_uniform(4)+1))!
            var rndRank = Rank(rawValue: Int(arc4random_uniform(13)+1))!
            var rndCard = Card(suit: rndSuit, rank: rndRank)
            p1 = rndCard
            rndSuit = Suit(rawValue: Int(arc4random_uniform(4)+1))!
            rndRank = Rank(rawValue: Int(arc4random_uniform(13)+1))!
            rndCard = Card(suit: rndSuit, rank: rndRank)
            p2 = rndCard
            rndSuit = Suit(rawValue: Int(arc4random_uniform(4)+1))!
            rndRank = Rank(rawValue: Int(arc4random_uniform(13)+1))!
            rndCard = Card(suit: rndSuit, rank: rndRank)
            p3 = rndCard
            rndSuit = Suit(rawValue: Int(arc4random_uniform(4)+1))!
            rndRank = Rank(rawValue: Int(arc4random_uniform(13)+1))!
            rndCard = Card(suit: rndSuit, rank: rndRank)
            p4 = rndCard
            rndSuit = Suit(rawValue: Int(arc4random_uniform(4)+1))!
            rndRank = Rank(rawValue: Int(arc4random_uniform(13)+1))!
            rndCard = Card(suit: rndSuit, rank: rndRank)
            p5 = rndCard
        }
        cards = [p1, p2, p3, p4, p5]
    }
    
    var description: String{
        return "\(cards)"
    }
}


let card = Card(suit: .Herz,rank: .ass)
print(card)
let hand = PokerHand()

print(hand)

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
