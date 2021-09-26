//
//  EmojiMemoryGameView.swift
//  Brainie
//
//  Created by Preet Patel on 5/06/21.
//

import SwiftUI

struct EmojiBrainieGameView: View {
    @ObservedObject var gameViewModel: EmojiBrainieGame
    @Namespace private var dealingNamespace
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                gameBody
                HStack {
                    restart
                    Spacer()
                    shuffle
                }
                .padding(.horizontal)
            }
            deckBody
        }
        .padding()
    }
    
    @State private var dealt = Set<Int>()
    
    private func deal(_ card: EmojiBrainieGame.Card) {
        dealt.insert(card.id)
    }
    
    private func isUndealt(_ card: EmojiBrainieGame.Card) -> Bool {
        return !dealt.contains(card.id)
    }
    
    private func zIndex(of card: EmojiBrainieGame.Card) -> Double {
        -Double(gameViewModel.cards.firstIndex(where: {$0.id == card.id}) ?? 0)
    }
    
    private func dealAnimation(for card: EmojiBrainieGame.Card) -> Animation {
        var delay = 0.0
        if let index = gameViewModel.cards.firstIndex(where: {$0.id == card.id}) {
            delay = Double(index) * (CardConstants.totalDealDuration / Double(gameViewModel.cards.count))
        }
        return Animation.easeInOut(duration: CardConstants.dealDuration).delay(delay)
    }
    var gameBody: some View {
        AspectVGrid(items: gameViewModel.cards, aspectRatio: 2/3) { card in
            if isUndealt(card) || (card.isMatched && !card.isFaceUp) {
                Color.clear
            } else {
            CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                .padding(4)
                .transition(AnyTransition.asymmetric(insertion: .identity, removal: .scale))
                .zIndex(zIndex(of: card))
                .onTapGesture {
                    withAnimation {
                        gameViewModel.choose(card)
                    }
                }
            }
        }
        .foregroundColor(CardConstants.color)
    }
    
    var deckBody: some View {
        ZStack {
            ForEach(gameViewModel.cards.filter(isUndealt)) { card in
                CardView(card: card)
                    .matchedGeometryEffect(id: card.id, in: dealingNamespace)
                    .transition(AnyTransition.asymmetric(insertion: .opacity, removal: .identity))
                    .zIndex(zIndex(of: card))
            }
        }
        .frame(width: CardConstants.undealtWidth, height: CardConstants.undealtHeight)
        .foregroundColor(CardConstants.color)
        .onTapGesture {
            for card in gameViewModel.cards {
                withAnimation(dealAnimation(for: card)) {
                    deal(card)
                }
            }
        }
    }
    
    var shuffle: some View {
        Button("Shuffle") {
            withAnimation {
                gameViewModel.shuffle()
            }
        }
    }
    
    var restart: some View {
        Button("Restart") {
            withAnimation {
                dealt = []
                gameViewModel.restart()
            }
        }
    }
    
    private struct CardConstants {
        static let color = Color.red
        static let aspectRatio: CGFloat = 2/3
        static let dealDuration: Double = 0.5
        static let totalDealDuration: Double = 2
        static let undealtHeight: CGFloat = 90
        static let undealtWidth = undealtHeight * aspectRatio
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let game = EmojiBrainieGame()
        game.choose(game.cards.first!)
        return EmojiBrainieGameView(gameViewModel: game)
            .preferredColorScheme(.light)
    }
}
