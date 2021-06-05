//
//  EmojiMemoryGameView.swift
//  Brainie
//
//  Created by Preet Patel on 5/06/21.
//

import SwiftUI

struct EmojiMemoryGameView: View {
    @ObservedObject var gameViewModel: EmojiBrainieGame
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 65))]) {
                ForEach(gameViewModel.cards) { card in
                    CardView(card: card)
                        .aspectRatio(2/3, contentMode: .fit)
                        .onTapGesture {
                            gameViewModel.choose(card)
                        }
                }
            }
        }
        .foregroundColor(.red)
        .padding(.horizontal)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiBrainieGame()
        EmojiMemoryGameView(gameViewModel: game)
            .preferredColorScheme(.light)
        EmojiMemoryGameView(gameViewModel: game)
            .preferredColorScheme(.dark)
    }
}
