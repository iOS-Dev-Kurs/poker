/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 EURE ANTWORT HIER
 Wir verwenden hier Structs, da keine Vererbung wie bei Klassen benötigt wird. Structs sind gut um statische Dinge zu repräsentieren, wie z.B. Karten.
 Enums verwenden wir, da die Einträge von Suit und Rank immer nur 4 bzw. 13 Möglichkeiten bieten, die sich gegenseitig ausschließen.
 */
enum Suit: Int, CustomStringConvertible{
    case Diamonds, Spades, Hearts, Clubs
    
    var description: String{
        switch self{
            case .Diamonds:
                return "diamond"
            case .Spades:
                return "spades"
            case .Hearts:
                return "hearts"
            case .Clubs:
                return "clubs"
        }
    }
}
    
enum Rank: Int, CustomStringConvertible{
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    
    var description: String{
        switch self{
        case .two:
            return "two"
        case .three:
            return "three"
        case .four:
            return "four"
        case .five:
            return "five"
        case .six:
            return "six"
        case .seven:
            return "seven"
        case .eight:
            return "eight"
        case .nine:
            return "nine"
        case .ten:
            return "ten"
        case .jack:
            return "jack"
        case .queen:
            return "queen"
        case .king:
            return "king"
        case .ace:
            return "ace"
        }
    }
}
/*extension Card: Equatable {}
func ==(lhs: Card, rhs:Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
 
}*/

struct Card: CustomStringConvertible{
    let suit: Suit
    let rank: Rank
    
    
    var description: String{
        return "\(suit),\(rank)"
    }
}
extension Cards: Equatable{}

struct PokerHand{
    let cards: [Card]
    /*let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
    let rndRank = Rank(rawValue: Int(arc4rankdom_uniform(13)))!
    let rndCard = Card(suit: rndSuit, rank: rndRank)*/

    var description: String {
        return "\(cards), \(cards), \(cards), \(cards), \(cards)"
    }
    init(){
        let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
        let rndRank = Rank(rawValue: Int(arc4rankdom_uniform(13)))!
        let rndCard = Card(suit: rndSuit, rank: rndRank)
    }
}


//: ## Testing
/*
var rankingCounts = [Ranking : Int]()
let samples = 1000
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
