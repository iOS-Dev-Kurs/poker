/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 EURE ANTWORT HIER
 1. only need one refernce to Card
 2. Enums eignen sich, weil es bei der Suit- und Rank-Auswahl mehrere Möglichkeiten gibt, welche sich gegenseitig ausschließen
*/


enum Rank: Int {
    case Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, Queen, King, Ace
    func RankDescription() -> String {
        switch self {
        case .Ace:
            return "Ace"
        case .King:
            return "Jack"
        case .Queen:
            return "Queen"
        case .Jack:
            return "King"
        case .Ten:
            return "Ten"
        case .Nine:
            return "Nine"
        case .Eight:
            return "Eight"
        case .Seven:
            return "Seven"
        case .Six:
            return "Six"
        case .Five:
            return "Five"
        case .Four:
            return "Four"
        case .Three:
            return "Three"
        case .Two:
            return "Two"
        }
    }
}

enum Suit: Int {
    case Spades, Hearts, Diamonds, Clubs
    func SuitDescription() -> String {
        switch self {
        case .Spades:
            return "U+2660"
        case .Hearts:
            return "U+2665"
        case .Diamonds:
            return "U+2666"
        case .Clubs:
            return "U+2663"
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
