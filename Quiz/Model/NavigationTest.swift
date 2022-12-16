//
//  NavigationTest.swift
//  Quiz
//
//  Created by AM Student on 12/2/22.
//

import SwiftUI

struct NavigationTest: View {
    var modelView: ContentView
    var gameManagerVM: GameManagerVM
    var backBoy: backgroundTest
    var body: some View {
        NavigationView {
            ZStack {
                NavigationLink(destination: modelView)  {
                    Text("Play")
                        .foregroundColor(.white)
                        .font(.system(size: 24, weight: .bold, design: .rounded))
                        .frame(width: 300, height: 100, alignment: .center)
                        .background(.blue.opacity(0.7))
                        .cornerRadius(30)
                }
            }
        }
        .navigationBarHidden(true)
        .background(backBoy)
        
    }
}

struct NavigationTest_Previews: PreviewProvider {
    static var previews: some View {
        NavigationTest(modelView: ContentView(gameManagerVM: GameManagerVM(), backBoy: backgroundTest()), gameManagerVM: GameManagerVM(), backBoy: backgroundTest())
    }
}
