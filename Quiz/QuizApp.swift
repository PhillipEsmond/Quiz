//
//  QuizApp.swift
//  Quiz
//
//  Created by AM Student on 11/22/22.
//

import SwiftUI

@main
struct QuizApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(gameManagerVM: GameManagerVM(), backBoy: backgroundTest())
        }
    }
}
