//
//  CardView.swift
//  Brainie
//
//  Created by Preet Patel on 5/06/21.
//

import SwiftUI

struct CardView: View {
    let card: EmojiBrainieGame.Card
    
    var body: some View {
        GeometryReader(content: { geometry in
            ZStack {
                let shape = RoundedRectangle(cornerRadius: 20)
                if card.isFaceUp {
                    shape.fill().foregroundColor(.white)
                    shape.strokeBorder(lineWidth: 3)
                    Text(card.content)
                        .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.7))
                } else if card.isMatched {
                    shape.opacity(0)
                } else {
                    shape.fill().foregroundColor(.red)
                }
            
            }
        })
    }
}
