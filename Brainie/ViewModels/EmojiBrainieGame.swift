//
//  EmojiBrainieGame.swift
//  Brainie
//
//  Created by Preet Patel on 5/06/21.
//

import SwiftUI

class EmojiBrainieGame: ObservableObject {
    typealias Card = BrainieGame<String>.Card
    private static let emojis: [String] = ["🎉", "👀", "🥁", "👋", "❤️", "😬", "🤪", "🩹", "🐰", "🔥", "🥲"]
    
    @Published private var model: BrainieGame<String> =
        BrainieGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            emojis[pairIndex]
        }
    
    var cards: Array<Card> {
        return model.cards
    }
    
    // MARK: = Intent(s)
    
    func choose(_ card: Card) {
        model.choose(card)
    }
    
    func shuffle() {
        model.shuffle()
    }
    
    func restart() {
        model = BrainieGame<String>(numberOfPairsOfCards: 8) { pairIndex in
            EmojiBrainieGame.emojis[pairIndex]
        }
    }
}
