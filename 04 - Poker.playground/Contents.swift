/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 EURE ANTWORT HIER
*/
import Foundation

enum Suit: Int, CustomStringConvertible  {
    
    case Karo, Herz, Pik, Kreuz

    var description: String {
        get {
            
            switch self{
                
            case .Karo:
                return "\u{2666}"
            case .Herz:
                return "\u{2665}"
            case .Pik:
                return "\u{2660}"
            case .Kreuz:
                return "\u{2663}"
                
                
            }

            
        }
    }
    
    
}

enum Rank: Int {
    
    case two, three, four, five, six, seven, eight, nine, ten, bube, dame, könig, ass
    
    var description: String {
        get {
            
            switch self{
                
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
            case .bube:
                return "Bube"
            case .dame:
                return "Dame"
            case .könig:
                return "König"
            case .ass:
                return "ass"


                
                
            }
            
            
        }
    }

}

enum Ranking: Int {
    case highCard, flush, straightFlush, fourOfaKind, fullHouse, straight, threeOfaKind, twoPair, onePair
    
    var description: String {
        switch self{
        case .flush:
            return "Flush"
        case .highCard:
            return "high Card"
        default:
            return "was anderes"
        }
    }
    
}

struct Card: CustomStringConvertible, Equatable  {
    
    let suit: Suit
    let rank: Rank
    
    var description: String {
        get{
            return "\(suit) \(rank)"
        }
    }
    
}

struct PokerHand {
    
    var cards = [Card(suit: Suit.Karo, rank: Rank.ass), Card(suit: Suit.Karo, rank: Rank.ass), Card(suit: Suit.Karo, rank: Rank.ass), Card(suit: Suit.Karo, rank: Rank.ass), Card(suit: Suit.Karo, rank: Rank.ass)]
    
    init() {
        
        var Anzahl_Karten = 0
        while Anzahl_Karten < 5 {
            
            let rndSuit = Suit(rawValue: Int(arc4random_uniform(4)))!
            let rndRank = Rank(rawValue: Int(arc4random_uniform(13)))!
            let rndCard = Card(suit: rndSuit, rank: rndRank)
            
            if self.cards.contains(rndCard){
               
            }
            else {
              self.cards[Anzahl_Karten] = rndCard
                Anzahl_Karten += 1
            }
            

            
        }
        
        
    }
    
    var description: String {
        get {
          return "\(self.cards[0]),\(self.cards[1]),\(self.cards[2]),\(self.cards[3]),\(self.cards[4])"
        }
    }
    
    var ranking: Ranking {
        
        if self.cards[0].suit == self.cards[1].suit && self.cards[0].suit == self.cards[2].suit && self.cards[0].suit == self.cards[3].suit && self.cards[0].suit == self.cards[4].suit {
            
            return .flush
            
        }
        else {
            
            return .highCard
        }
    }
    
}

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}

//let Kart = Card(suit: Suit.Karo, rank: Rank.bube)
//let Kart2 = Card(suit: Suit.Karo, rank: Rank.ass)
//Kart == Kart2
//let Hand = PokerHand()
//Hand.description
//: ## Testing

var rankingCounts = [Ranking : Int]()
let samples = 999
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

