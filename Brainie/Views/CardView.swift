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
                    Pie(startAngle: Angle(degrees: 0-90), endAngle: Angle(degrees: 110-90)).padding(6).opacity(0.5)
                    Text(card.content)
                    .rotationEffect(Angle.degrees(card.isMatched ? 360 : 0))
                        .font(Font.system(size: min(geometry.size.width, geometry.size.height) * 0.7))
                        .animation(Animation.linear(duration: 1).repeatForever(autoreverses: true))
            }
            .cardify(isFaceUp: card.isFaceUp)
        })
    }
}
