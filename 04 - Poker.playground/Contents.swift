//: Playground - noun: a place where people can play

import UIKit

/*
 Enum für Farben
 */
enum Suit : Int {
    case Karo = 1, Herz = 2, Pik = 3, Kreuz = 4
    var symbol: String {
        switch(self.rawValue) {
        case 1: return "\u{2662}"
        case 2: return "\u{2661}"
        case 3: return "\u{2664}"
        case 4: return "\u{2667}"
        default: return "Something went wrong"
        }
    }
}



/*
 Enum für Werte der Karten
 -> 0 für Vergleichszwecke
 */
enum Rank : Int {
    case Nothing = 0, Zwei = 1, Drei = 2, Vier = 3, Fünf = 4, Sechs = 5, Sieben = 6, Acht = 7, Neun = 8, Zehn = 9, Bube = 10, Dame = 11, König = 12, Ass = 13
    var symbol: String {
        switch(self.rawValue) {
        case 0: return "Nichts"
        case 1: return "2"
        case 2: return "3"
        case 3: return "4"
        case 4: return "5"
        case 5: return "6"
        case 6: return "7"
        case 7: return "8"
        case 8: return "9"
        case 9: return "10"
        case 10: return "B"
        case 11: return "D"
        case 12: return "K"
        case 13: return "A"
        default: return "Something went wrong"
        }
    }
}



/*
 Struct für Karten mit Vergleichsoption
 */
struct Card : Equatable {
    let suit: Suit
    let rank: Rank
    var description: String {
        return suit.symbol + rank.symbol
    }
}
// Vergleich der Karten
func ==(lhs: Card, rhs: Card) -> Bool {
    return lhs.suit == rhs.suit && lhs.rank == rhs.rank
}




/*
 Enum für Ranking
 */
enum Ranking : Int {
    
    case Highcard = 0, OnePair = 1, TwoPair = 2, ThreeOfAKind = 3, Straight = 4, Flush = 5, FullHouse = 6, FourOfAKind = 7, StraightFlush = 8, RoyalFlush = 9
    var description: String {
        switch self.rawValue {
        case 0:
            return "Highcard"
        case 1:
            return "One Pair"
        case 2:
            return "Two Pair"
        case 3:
            return "Three of a kind"
        case 4:
            return "Straight"
        case 5:
            return "Flush"
        case 6:
            return "Full House"
        case 7:
            return "Four of a kind"
        case 8:
            return "Straight Flush"
        case 9:
            return "Royal Flush"
        default:
            return "Something went wrong"
        }
    }
}
// Funktion, die Karten rankt
func getRankingInt(cards: [Card]) -> [Int] {
    // Initialisierung der Variablen
    var rankingInt = 0
    var highestCard = 0
    var secondHighestCard = 0
    var thirdHighestCard = 0
    
    
    // Sortiere die Werte in Array werte
    var werte_unsortiert: [Rank] = []
    for card in cards {
        werte_unsortiert.append(card.rank)
    }
    var werte = werte_unsortiert.sort {
        return $0.rawValue < $1.rawValue
    }
    highestCard = werte[4].rawValue
    secondHighestCard = werte[3].rawValue
    thirdHighestCard = werte[2].rawValue
    
    // One Pair, Three of a type, Trilling
    var OnePairOf = 0
    var SecondPairOf = 0
    var DrillingOf = 0
    var VierlingOf = 0
    
    for i in 1 ... 4 {
        if(werte[i].rawValue == werte[i - 1].rawValue) { // Pärchen gefunden
            if(OnePairOf == 0) { // Falls erstes Pärchen
                OnePairOf = werte[i].rawValue
            }
            else { // Falls zweites Pärchen
                SecondPairOf = werte[i].rawValue
            }
            
            if(i < 4 && werte[i + 1].rawValue == werte[i].rawValue) { // Drilling gefunden
                DrillingOf = werte[i].rawValue
            }
            if(i < 3 && werte[i + 1].rawValue == werte[i].rawValue && werte[i + 2].rawValue == werte[i].rawValue) { // Vierling gefunden
                VierlingOf = werte[i].rawValue
            }
        }
    }
    

    if(VierlingOf != 0) { // Vierling
        rankingInt = 7
        highestCard = VierlingOf // höchste Karte ist Vierling selber
        for i in 0 ... 4 {
            if(werte[i].rawValue != VierlingOf) {
                secondHighestCard = werte[i].rawValue // verbleibende Karte für secondHighest
                break
            }
        }
        thirdHighestCard = 0
    }
    else if (DrillingOf != 0) {
        if(OnePairOf != DrillingOf || SecondPairOf != DrillingOf) { // Full House?
            rankingInt = 6
            highestCard = DrillingOf // Highest Card Drilling
            secondHighestCard = (DrillingOf != OnePairOf) ? OnePairOf : SecondPairOf //secondHighest verbleibendes Pärchen
            thirdHighestCard = 0
        }
        else { // Ansonsten Drillling
            rankingInt = 3
            highestCard = DrillingOf // Höchste Karte Drilling selber
            secondHighestCard = 0 // Reset für kommende Schleife
            for i in 0 ... 4 {
                if(werte[i].rawValue != DrillingOf) {
                    if(secondHighestCard == 0) { // Falls erste Karte ungleich Drilling
                        secondHighestCard = werte[i].rawValue
                    }
                    else if(werte[i].rawValue > secondHighestCard) { // Falls zweite Karte ungleich Dirlling und größer als zuerst gefundene
                        thirdHighestCard = secondHighestCard
                        secondHighestCard = werte[i].rawValue
                    }
                    else {
                        thirdHighestCard = werte[i].rawValue
                    }
                }
            }
        }
    }
    else if (SecondPairOf != 0 && SecondPairOf != OnePairOf) {
        rankingInt = 2 // Zwei Paare
        highestCard = (OnePairOf < SecondPairOf) ? SecondPairOf : OnePairOf // Höchste Karte höchstes Paar und zweites...
        secondHighestCard = (OnePairOf > SecondPairOf) ? SecondPairOf : OnePairOf
        for i in 0 ... 4 {
            if(werte[i].rawValue != OnePairOf && werte[i].rawValue != OnePairOf) {
                thirdHighestCard = werte[i].rawValue // Dritte Karte: Höchste verbleibende Karte
            }
        }
    }
    else if (OnePairOf != 0) {
        rankingInt = 1
        highestCard = OnePairOf // Höchste Karte Pärchen
        if(werte[4].rawValue == OnePairOf) { // Falls Pärchen am Ende sitzt
            if(werte[3].rawValue == OnePairOf) { // Falls vollständig am ende
                secondHighestCard = werte[2].rawValue
                thirdHighestCard = werte[1].rawValue
            }
            else { // Fals nicht vollständig am Ende
                secondHighestCard = werte[3].rawValue
                thirdHighestCard = (werte[2].rawValue == OnePairOf) ? werte[1].rawValue : werte[2].rawValue
            }
        }
    }

    
    
    // Flush?
    var hasFlush = true
    for card in cards {
        if(card.suit != cards[0].suit) {
            hasFlush = false
            break
        }
    }
    if(hasFlush && rankingInt < 5) {
        rankingInt = 5
        highestCard = werte[4].rawValue // Höchste Karte usw folgt Reihenfolge
        secondHighestCard = werte[3].rawValue
        thirdHighestCard = werte[2].rawValue
    }
    
    // Straight?
    var hasStraight = true
    for i in 1 ... 4 {
        if(werte[i].rawValue - werte[i - 1].rawValue != 1) {
            hasStraight = false
            break
        }
    }
    if(hasStraight && hasFlush) { // Straight-Flush?
        if(werte[4].rawValue == 13) { // RoyalFlush
            rankingInt = 9
        }
        else {
            rankingInt = 8
            highestCard = werte[4].rawValue // Bei Straight-Flush gibt es nur die Höchste Karte
            secondHighestCard = 0
            thirdHighestCard = 0
        }
        
    }
    else if(hasStraight && rankingInt < 4) {
        rankingInt = 4
        highestCard = werte[4].rawValue
        secondHighestCard = 0
        thirdHighestCard = 0
    }
    
    return [rankingInt, highestCard, secondHighestCard, thirdHighestCard]
}

// Poker-Hand
struct PokerHand: Comparable {
    let cards: [Card]
    
    // Befüllen der Hand -> Falls Karten übergeben, diese benutzen
    init(cardsOnTable: [Card], initialCards: [Card]) {
        cards = initialCards
        let rankingInt = getRankingInt(cardsOnTable + cards)
        self.ranking = Ranking(rawValue: rankingInt[0])!
        self.highestCard = Rank(rawValue: rankingInt[1])!
        self.secondHighestCard = Rank(rawValue: rankingInt[2])!
        self.thirdHighestCard = Rank(rawValue: rankingInt[3])!
        
    }
    
    // Ausgabe der Karten
    var description: String {
        var toreturn = ""
        for card in cards {
            toreturn += "  " + card.description + "  "
        }
        return toreturn
    }
    
    var ranking: Ranking
    var highestCard: Rank
    var secondHighestCard: Rank
    var thirdHighestCard: Rank
    
}
func <(lhs: PokerHand, rhs: PokerHand) -> Bool {
    if(lhs.ranking.rawValue < rhs.ranking.rawValue) {
        return true
    }
    else if(lhs.ranking.rawValue == rhs.ranking.rawValue && lhs.highestCard.rawValue < rhs.highestCard.rawValue) {
        return true
    }
    else if(lhs.ranking.rawValue == rhs.ranking.rawValue && lhs.secondHighestCard.rawValue < rhs.secondHighestCard.rawValue) {
        return true
    }
    else if(lhs.ranking.rawValue == rhs.ranking.rawValue && lhs.thirdHighestCard.rawValue < rhs.thirdHighestCard.rawValue) {
        return true
    }
    else {
        return false
    }
}
func ==(lhs: PokerHand, rhs: PokerHand) -> Bool {
    if(lhs.ranking.rawValue == rhs.ranking.rawValue) {
        if(lhs.highestCard.rawValue != rhs.highestCard.rawValue) {
            return false
        }
        else if (lhs.secondHighestCard.rawValue != rhs.secondHighestCard.rawValue) {
            return false
        }
        else if (lhs.thirdHighestCard.rawValue != rhs.thirdHighestCard.rawValue) {
            return false
        }
        else {
            return true
        }
    }
    else
    {
        return false
    }
}
func makeDeck(anzahlDecks: Int?) -> [Card] {
    var defaultAnzahl = 2
    var returnDeck: [Card] = []
    
    if let anzahl = anzahlDecks where anzahlDecks > 1 {
        defaultAnzahl = anzahl
    }
    for _ in 1 ... defaultAnzahl {
        for j in 1 ... 4 {
            for k in 1 ... 13 {
                returnDeck.append(Card(suit: Suit(rawValue: j)!, rank: Rank(rawValue: k)!))
            }
        }
    }
    return returnDeck
}
struct Tisch {
    init(anazahlSpieler: Int, deck: [Card]?) {
        var tmpDeck: [Card]
        if let forcedDeck = deck {
            tmpDeck = forcedDeck
        } else {
            tmpDeck = makeDeck(1)
        }
        
        self.Deck = tmpDeck
        
        // Drei Karten auf den Tisch
        KartenAufTisch.append(self.Deck[getUnused()])
        KartenAufTisch.append(self.Deck[getUnused()])
        KartenAufTisch.append(self.Deck[getUnused()])
        
        for _ in 1 ... anazahlSpieler {
            let Karte1 = self.Deck[getUnused()]
            let Karte2 = self.Deck[getUnused()]
            self.Spieler.append(PokerHand(cardsOnTable: self.KartenAufTisch, initialCards: [Karte1, Karte2]))

        }
    }
    
    mutating func getUnused() -> Int {
        var number = Int(arc4random_uniform(UInt32(self.Deck.count - 1)))
        while(self.usedCards.contains(number)) {
            number = Int(arc4random_uniform(UInt32(self.Deck.count - 1)))
        }
        self.usedCards.append(number)
        return number
    }
    var KartenAufTisch: [Card] = []
    var Deck: [Card] = []
    var usedCards: [Int] = []
    var Spieler: [PokerHand] = []
    
    var wholeTisch: String {
        var toreturn = "Auf dem Tisch:"
        for card in KartenAufTisch {
            toreturn += " "+card.description
        }
        toreturn += "\n"
        for i in 1 ... self.Spieler.count {
            toreturn += "Spieler \(i): " + self.Spieler[i-1].description + ", das ist " + self.Spieler[i-1].ranking.description
            toreturn += "\n"
        }
        toreturn += "Sieger: \(self.Sieger.description) (\(self.Sieger.ranking), höchste Karte \(self.Sieger.highestCard))"
        return toreturn
    }
    // Ermittelt Sieger des Tisches
    var Sieger: PokerHand {
        let sorted = self.Spieler.sort()
        return sorted.last!
    }
}




//: Testing
var tisch1 = Tisch(anazahlSpieler: 2, deck: nil)
print(tisch1.wholeTisch)

var tisch2 = Tisch(anazahlSpieler: 2, deck: nil)
print(tisch2.wholeTisch)

var tisch3 = Tisch(anazahlSpieler: 2, deck: nil)
print(tisch3.wholeTisch)


