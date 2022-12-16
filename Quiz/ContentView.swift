//
//  ContentView.swift
//  Quiz
//
//  Created by AM Student on 11/22/22.
//

import SwiftUI
import Foundation
import AVFoundation

var audioPlayer: AVAudioPlayer?

func playSound(sound: String, type: String) {
    if let path = Bundle.main.path(forResource: sound, ofType: type) {
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
            audioPlayer?.play()
        } catch {
            print("ERROR: Could not find and play the sound file!")
        }
    }
}

struct ContentView: View {
    @ObservedObject var gameManagerVM: GameManagerVM
    
    
    var backBoy: backgroundTest
    
    var body: some View {
            ZStack {
                if (gameManagerVM.model.quizCompleted) {
                    QuizCompletedView(gameManagerVM: gameManagerVM)
                } else {
                    VStack {
                        ReusableText(text: "Animal Knowledge Quiz!", size: 30)
                            .padding()
                        
                        ReusableText(text: gameManagerVM.model.quizModel.question, size: 25)
                            .lineLimit(3)
                            .frame(width: UIScreen.main.bounds.size.width - 20, height: 60, alignment: .center)
                            .multilineTextAlignment(.center)
                        
                        Spacer()
                        
                        ZStack {
                            Circle()
                                .stroke(lineWidth: 15)
                                .foregroundColor(.gray)
                                .opacity(0.3)
                            
                            Circle()
                                .trim(from: 0.0, to: min(CGFloat(gameManagerVM.progress),1.0))
                                .stroke(LinearGradient(colors: [.orange, .red], startPoint: .topLeading, endPoint: .bottomTrailing),
                                        style: StrokeStyle(lineWidth: 20, lineCap: .round, lineJoin: .round))
                                .rotationEffect(Angle(degrees: 270))
                                .animation(Animation.linear(duration: Double(gameManagerVM.maxProgress)), value: gameManagerVM.progress)
                            
                            ReusableText(text: String(gameManagerVM.progress), size: 30)
                        }.frame(width: 150, height: 150)
                        
                        
                        Spacer()
                        
                        OptionsGridView(gameManagerVM: gameManagerVM)
                    }
                }
            }
            .background(backBoy)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(gameManagerVM: GameManagerVM(), backBoy: backgroundTest())
    }
}

