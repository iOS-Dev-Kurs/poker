/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*Wieso struct? Weil Karten statische Dinge sind*/
struct Card: CustomStringConvertible {
    /*Wieso enum? Weil sich die Faelle gegenseitig ausschließen und nur eine Karte eine Farbe und einen Rang haben kann */
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
    enum Rank: Int, CustomStringConvertible {
        case two = 2, three = 3, four = 4, five = 5, six = 6, seven = 7, eight = 8, nine = 9, ten = 10, bube = 11, dame = 12, koenig = 13, ass = 14
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
    let suit: Suit
    let rank: Rank
    
    var description: String{
    return "\(suit) \(rank)"
    }
    

}

struct PokerHand {
    let cards: [Card]
    
    var description: String{
        return "\(cards)"
    }
    
    /*init(cards: [Card]){
    }*/
}

let card = Card(suit: .Herz,rank: .ass)
print(card)


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
