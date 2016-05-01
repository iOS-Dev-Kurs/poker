/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 EURE ANTWORT HIER
 Wir nutzen für Card ein Struct, da es sich um eine statische Sache handelt, die sich nicht ändert. (und nicht als Referenz übergeben werden soll, wenn wir eine Hand erzeugen.)
 Für Suit und Rank kommen am besten Enums in Frage, weil
*/
import Foundation

enum Suit: Int, CustomStringConvertible {
    case diamonds, hearts, clubbs,spades
    
    var description: String {
        switch self {
        case .diamonds: return "♦"
        case .clubbs: return "♣"
        case .hearts: return "♥"
        case .spades: return "♣"
        }
    }
}

enum Rank: Int {
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    var description: String{
        switch self {
        case .two: return "2"
        case .three: return "3"
        case .four: return "4"
        case .five: return "5"
        case .six: return   "6"
        case .seven: return "7"
        case .eight: return "8"
        case .nine: return "9"
        case .ten: return "10"
        case .jack: return "J"
        case .queen: return "Q"
        case .king: return "K"
        case .ace: return "A"
        }
    }
}

struct Card: CustomStringConvertible {
    let suit: Suit
    let rank: Rank
    
    var description: String {
        return "\(rank) \(suit)"
        
    }
}

struct PokerHand: CustomStringConvertible{
    let cards: [Card]
    var description: String {
    return PrintHand()
    }
    
    
    // Initializer
    init() {
        let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
        let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
        let rndCard = Card(suit: rndSuit, rank: rndRank)
        
        for i in 0...5 {
        while self.cards.contains(rndCard) {
            let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
            let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
            let rndCard = Card(suit: rndSuit, rank: rndRank)
        }
        self.cards.append(rndCard)
        }
    }
    
    func NewRandomCard () -> Card {
        let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
        let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
        let rndCard = Card(suit: rndSuit, rank: rndRank)
        return rndCard
    }
    
    func PrintHand() -> String {
        var variableString: String = ""
        for card in self.cards {
            variableString+=card.description
        }
        return variableString
    }
}


extension Card: Equatable {}

func ==(lhs: Card, rhs: Card) -> Bool {
        return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}



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
