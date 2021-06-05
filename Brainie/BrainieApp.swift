//
//  BrainieApp.swift
//  Brainie
//
//  Created by Preet Patel on 5/06/21.
//

import SwiftUI

@main
struct BrainieApp: App {
    let game = EmojiBrainieGame()
    var body: some Scene {
        WindowGroup {
            EmojiMemoryGameView(gameViewModel: game)
        }
    }
}
