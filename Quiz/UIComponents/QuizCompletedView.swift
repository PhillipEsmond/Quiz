//
//  QuizCompletedView.swift
//  Quiz
//
//  Created by AM Student on 11/29/22.
//

import Foundation
import SwiftUI

struct QuizCompletedView: View {
    var gameManagerVM: GameManagerVM
    var body: some View {
        VStack {
            Image(systemName: "gamecontroller.fill")
                .foregroundColor(Color.yellow)
                .font(.system(size: 60))
                .padding()
            
            ReusableText(text: gameManagerVM.model.quizWinningStatus ?
                         "THAT'S A WRAP" :
                             "GAME OVER",
                          size: 30)
            .padding()
            
            ReusableText(text: gameManagerVM.model.quizWinningStatus
                        ? "Thank you for playing!!"
                        : "Better luck next time",
                          size: 30)
            .padding()
            
            Button {
                gameManagerVM.restartGame()
            } label: {
                HStack {
                    Image(systemName: "play.fill")
                        .foregroundColor(.white)
                        .font(.system(size: 24))
                        .padding()
                    
                    Text("Play Again")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                }
            }.frame(width: 300, height: 100, alignment: .center)
                .background(.blue.opacity(0.2))
                .cornerRadius(30)
        }
        .frame(width: 500, height: 1000)
    }
}
