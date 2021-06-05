//
//  EmojiMemoryGameView.swift
//  Brainie
//
//  Created by Preet Patel on 5/06/21.
//

import SwiftUI

struct EmojiBrainieGameView: View {
    @ObservedObject var gameViewModel: EmojiBrainieGame
    var body: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
            CardView(card: card)
                .padding(4)
                .onTapGesture {
                    gameViewModel.choose(card)
                }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiBrainieGame()
        EmojiBrainieGameView(gameViewModel: game)
            .preferredColorScheme(.light)
        EmojiBrainieGameView(gameViewModel: game)
            .preferredColorScheme(.dark)
    }
}
