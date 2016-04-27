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
    
    var description: String{
        return "\(cards)"
    }
    
    /*init(cards: [Card]){
        for index in 1...5 {
            let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
            let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
            let rndCard = Card(suit: rndSuit, rank: rndRank)
            self.cards = [rndCard]
        }
        
    }*/
}


let card = Card(suit: .Herz,rank: .ass)
print(card)
print("Hello World!")

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
