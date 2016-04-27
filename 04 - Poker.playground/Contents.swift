/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 EURE ANTWORT HIER
 
 Enums verwenden wir, da die Einträge von Suit und Rank immer nur 4 bzw. 13 Möglichkeiten bieten.
 */
enum Suit: Int{
    case Diamonds, Spades, Hearts, Clubs
    func suitDescription() -> String{
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
enum Rank: Int{
    case two, three, four, five, six, seven, eight, nine, ten, jack, queen, king, ace
    func rankDescription() -> String{
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
