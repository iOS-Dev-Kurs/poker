/*:
 # Übungsaufgabe 4 - Poker
 
 In dieser Aufgabe berechnen wir die Wahrscheinlichkeit für einen _Flush_ beim Poker.

 - Wir modellieren `Card` als Struct, und `Suit` und `Rank` als Enums. Warum verwenden wir keine Klasse für `Card`? Warum eignet sich ein Enum so hervorragend für `Suit` und `Rank`?
*/
/*
 Eine Karte ist nur eine Kombination aus Farbe und Wert, dafür reicht ein struct aus. Die Vererbungseigenschaft der Klasse wird nicht benötigt.
 Eine Karte besitzt auch nur genau eine Farbe und einen Wert, genau dafür ist das enum gedacht.
 
 Lösungen für Aufgabe 2 und 3 unter https://github.com/marvinruder/fibonacci und https://github.com/marvinruder/isprimenumber
 */





//: ## Testing
import UIKit

enum Suit: Int {
    case diamonds = 1
    case hearts = 2
    case clubs = 3
    case spades = 4
}

enum Rank: Int {
    case deuce = 2
    case three = 3
    case four = 4
    case five = 5
    case six = 6
    case seven = 7
    case eight = 8
    case nine = 9
    case ten = 10
    case jack = 11
    case queen = 12
    case king = 13
    case ace = 1
}

struct Card {
    var suit: Suit
    var rank: Rank
    var Description: String {
        switch self.suit {
        case .diamonds:
            switch self.rank {
            case .deuce:
                return "🃂"
            case .three:
                return "🃃"
            case .four:
                return "🃄"
            case .five:
                return "🃅"
            case .six:
                return "🃆"
            case .seven:
                return "🃇"
            case .eight:
                return "🃈"
            case .nine:
                return "🃉"
            case .ten:
                return "🃊"
            case .jack:
                return "🃋"
            case .queen:
                return "🃍"
            case .king:
                return "🃎"
            case .ace:
                return "🃁"
            }
        case .hearts:
            switch self.rank {
            case .deuce:
                return "🂲"
            case .three:
                return "🂳"
            case .four:
                return "🂴"
            case .five:
                return "🂵"
            case .six:
                return "🂶"
            case .seven:
                return "🂷"
            case .eight:
                return "🂸"
            case .nine:
                return "🂹"
            case .ten:
                return "🂺"
            case .jack:
                return "🂻"
            case .queen:
                return "🂽"
            case .king:
                return "🂾"
            case .ace:
                return "🂱"
            }
            
        case .spades:
            switch self.rank {
            case .deuce:
                return "🂢"
            case .three:
                return "🂣"
            case .four:
                return "🂤"
            case .five:
                return "🂥"
            case .six:
                return "🂦"
            case .seven:
                return "🂧"
            case .eight:
                return "🂨"
            case .nine:
                return "🂩"
            case .ten:
                return "🂪"
            case .jack:
                return "🂫"
            case .queen:
                return "🂭"
            case .king:
                return "🂮"
            case .ace:
                return "🂡"
            }
            
        case .clubs:
            switch self.rank {
            case .deuce:
                return "🃒"
            case .three:
                return "🃓"
            case .four:
                return "🃔"
            case .five:
                return "🃕"
            case .six:
                return "🃖"
            case .seven:
                return "🃗"
            case .eight:
                return "🃘"
            case .nine:
                return "🃙"
            case .ten:
                return "🃚"
            case .jack:
                return "🃛"
            case .queen:
                return "🃝"
            case .king:
                return "🃞"
            case .ace:
                return "🃑"
            }
                    }
    }
}

extension Card: Equatable { }

func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}
struct PokerHand {
    var cards: [Card] = []
    var description: String {
        var Cards: String = ""
        for i in 0...4 {
            Cards += cards[i].Description
        }
        return Cards
    }
    var ranking: Ranking {
        var sameRank = 0
        var cardRanks = [0,0,0,0,0,0,0,0,0,0,0,0,0,0]
        for i in 0...4 {
            for j in 0...4 {
                if cards[i].rank == cards[j].rank {
                    sameRank += 1
                }
            }
            switch cards[i].rank {
            case .deuce:
                cardRanks[1] += 1
            case .three:
                cardRanks[2] += 1
            case .four:
                cardRanks[3] += 1
            case .five:
                cardRanks[4] += 1
            case .six:
                cardRanks[5] += 1
            case .seven:
                cardRanks[6] += 1
            case .eight:
                cardRanks[7] += 1
            case .nine:
                cardRanks[8] += 1
            case .ten:
                cardRanks[9] += 1
            case .jack:
                cardRanks[10] += 1
            case .queen:
                cardRanks[11] += 1
            case .king:
                cardRanks[12] += 1
            case .ace:
                cardRanks[13] += 1
                cardRanks[0] += 1
            }
        }
        
        if sameRank == 7 {
            return Ranking.Pair
        } else if sameRank == 9 {
            return Ranking.TwoPairs
        } else if sameRank == 11 {
            return Ranking.ThreeOfAKind
        } else if sameRank == 13 {
            return Ranking.FullHouse
        } else if sameRank == 17 {
            return Ranking.FourOfAKind
        } else if cards[0].suit == cards[1].suit && cards[1].suit == cards[2].suit && cards[2].suit == cards[3].suit && cards[3].suit == cards[4].suit {
            if cardRanks == [1,1,1,1,1,0,0,0,0,0,0,0,0,0] || cardRanks == [0,1,1,1,1,1,0,0,0,0,0,0,0,0] || cardRanks == [0,0,1,1,1,1,1,0,0,0,0,0,0,0] || cardRanks == [0,0,0,1,1,1,1,1,0,0,0,0,0,0] || cardRanks == [0,0,0,0,1,1,1,1,1,0,0,0,0,0] || cardRanks == [0,0,0,0,0,1,1,1,1,1,0,0,0,0] || cardRanks == [0,0,0,0,0,1,1,1,1,1,0,0,0,0] || cardRanks == [0,0,0,0,0,0,1,1,1,1,1,0,0,0] || cardRanks == [0,0,0,0,0,0,0,1,1,1,1,1,0,0] || cardRanks == [0,0,0,0,0,0,0,0,1,1,1,1,1,0] || cardRanks == [0,0,0,0,0,0,0,0,0,1,1,1,1,1] {
                print("Awesome! Straight flush: " + cards[0].Description + cards[1].Description + cards[2].Description + cards[3].Description + cards[4].Description)
                return Ranking.StraightFlush
            } else {
                return Ranking.Flush
            }
        } else if cardRanks == [1,1,1,1,1,0,0,0,0,0,0,0,0,0] || cardRanks == [0,1,1,1,1,1,0,0,0,0,0,0,0,0] || cardRanks == [0,0,1,1,1,1,1,0,0,0,0,0,0,0] || cardRanks == [0,0,0,1,1,1,1,1,0,0,0,0,0,0] || cardRanks == [0,0,0,0,1,1,1,1,1,0,0,0,0,0] || cardRanks == [0,0,0,0,0,1,1,1,1,1,0,0,0,0] || cardRanks == [0,0,0,0,0,1,1,1,1,1,0,0,0,0] || cardRanks == [0,0,0,0,0,0,1,1,1,1,1,0,0,0] || cardRanks == [0,0,0,0,0,0,0,1,1,1,1,1,0,0] || cardRanks == [0,0,0,0,0,0,0,0,1,1,1,1,1,0] || cardRanks == [0,0,0,0,0,0,0,0,0,1,1,1,1,1] {
            return Ranking.Straight
        } else {
            return Ranking.OtherStuff
        }
    }
    
    init() {
        var i = 0
        while i < 5 {
            let rndSuit = Suit(rawValue: Int(arc4random_uniform(4) + 1))!
            let rndRank = Rank(rawValue: Int(arc4random_uniform(13) + 1))!
            let rndCard = Card(suit: rndSuit, rank: rndRank)
            cards.append(rndCard)
            var isNewCard = true
            if i > 0 {
                for j in 0...i-1 {
                    if rndCard == cards[j] {
                        isNewCard = false
                        cards.removeLast()
                    }
                }
            }
            if isNewCard {
                i += 1
            }
        }
    }
}

enum Ranking: String {
    case StraightFlush = "a straight flush (including royal flush)"
    case FourOfAKind = "four of a kind"
    case FullHouse = "a full house"
    case Flush = "a flush"
    case Straight = "a straight"
    case ThreeOfAKind = "three of a kind"
    case TwoPairs = "two pairs"
    case Pair = "a pair"
    case OtherStuff = "other stuff"
}

extension Ranking: CustomStringConvertible {
    var description: String {
        return "\(rawValue)"
    }
}

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
    print("The probability of being dealt \(ranking.description) is about \(Double(count) / Double(samples) * 100)%")
}

// Results from n = 100000 compared to actual probabilities
//The probability of being dealt a straight flush (including royal flush) is about 0.001%  | 0.0015%
//The probability of being dealt a full house is about 0.149% | 0.1441%
//The probability of being dealt a straight is about 0.309% | 0.39%
//The probability of being dealt two pairs is about 4.765% | 4.75%
//The probability of being dealt a pair is about 42.636% |42.26%
//The probability of being dealt three of a kind is about 2.079% | 2.11%
//The probability of being dealt a flush is about 0.198% | 0.196%
//The probability of being dealt other stuff is about 49.837% | 50.11%
//The probability of being dealt four of a kind is about 0.027% | 0.0024%

