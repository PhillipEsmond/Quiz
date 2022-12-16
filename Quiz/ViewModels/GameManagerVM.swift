//
//  GameManagerVM.swift
//  Quiz
//
//  Created by AM Student on 11/22/22.
//

import Foundation
import SwiftUI

class GameManagerVM : ObservableObject {
    
    static var currentIndex = 0
    
    static func createGameModel(i: Int) -> Quiz {
        return Quiz(currentQuestionIndex: i, quizModel: quizData[i], quizCompleted: false)
    }
    
    @Published var model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
    
    var timer = Timer()
    var maxProgress = 30
    @Published var progress = 0
    
    init() {
        self.start()
    }
    
    func verifyAnswer(selectOption: QuizOption) {
        for index in model.quizModel.optionList.indices {
            model.quizModel.optionList[index].isMatched = false
            model.quizModel.optionList[index].isSelected = false
            
        }
        if let index = model.quizModel.optionList.firstIndex(where: {$0.optionId == selectOption.optionId}) {
            if selectOption.optionId ==  model.quizModel.answer {
                model.quizModel.optionList[index].isMatched = true
                model.quizModel.optionList[index].isSelected = true
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    if (GameManagerVM.currentIndex < 5) {
                        GameManagerVM.currentIndex = GameManagerVM.currentIndex + 1
                        self.model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
                    } else {
                        self.model.quizCompleted = true
                        self.model.quizWinningStatus = true
                        self.reset()
                    }
                }
            } else {
                model.quizModel.optionList[index].isMatched = false
                model.quizModel.optionList[index].isSelected = true
            }
        }
    }
    
    func restartGame() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { time in
            if self.progress == self.maxProgress {
                self.model.quizCompleted = true
                self.model.quizWinningStatus = false
                self.reset()
            } else {
                self.progress += 1
            }
        })
        GameManagerVM.currentIndex = 0
        model = GameManagerVM.createGameModel(i: GameManagerVM.currentIndex)
    }
    
    func start() {
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { time in
            if self.progress == self.maxProgress {
                self.model.quizCompleted = true
                self.model.quizWinningStatus = false
                self.reset()
            } else {
                self.progress += 1
            }
        })
    }
    
    func reset () {
        timer.invalidate()
        self.progress = 0
    }
    
}

extension GameManagerVM
{
    static var quizData: [QuizModel] {
        [
        QuizModel(question: "Which is the fastest animal in the world?",
                  answer: "B",
                  optionList: [QuizOption(id: 11, optionId: "A", option: "Turtle", color: Color.yellow),
                               QuizOption(id: 12, optionId: "B", option: "Cheetah", color: Color.red),
                               QuizOption(id: 13, optionId: "C", option: "Rabbit", color: Color.green),
                               QuizOption(id: 14, optionId: "D", option: "Leoprd", color: Color.purple)]),
        
        QuizModel(question: "Which of the animals swims in upright position",
                  answer: "C",
                  optionList: [QuizOption(id: 21, optionId: "A", option: "Sea Lion", color: Color.yellow),
                               QuizOption(id: 22, optionId: "B", option: "Sea Urchin", color: Color.red),
                               QuizOption(id: 23, optionId: "C", option: "Seahorse", color: Color.green),
                               QuizOption(id: 24, optionId: "D", option: "Sea slug", color: Color.purple)]),
        
        QuizModel(question: "Which is the world's largest living fish?",
                  answer: "B",
                  optionList: [QuizOption(id: 31, optionId: "A", option: "Manta Ray", color: Color.yellow),
                               QuizOption(id: 32, optionId: "B", option: "Whale Shark", color: Color.red),
                               QuizOption(id: 33, optionId: "C", option: "Marlin", color: Color.green),
                               QuizOption(id: 34, optionId: "D", option: "Sailfish", color: Color.purple)]),
        
        QuizModel(question: "The tiniest animal with a backbone is a what?",
                  answer: "D",
                  optionList: [QuizOption(id: 41, optionId: "A", option: "Fish", color: Color.yellow),
                               QuizOption(id: 42, optionId: "B", option: "Lizard", color: Color.red),
                               QuizOption(id: 43, optionId: "C", option: "Bird", color: Color.green),
                               QuizOption(id: 44, optionId: "D", option: "Frog", color: Color.purple)]),
        
        QuizModel(question: "The largest “town” home to what animal was an underground colony measuring 25,000 square miles, found in Texas?",
                  answer: "D",
                  optionList: [QuizOption(id: 41, optionId: "A", option: "Meerkat", color: Color.yellow),
                               QuizOption(id: 42, optionId: "B", option: "Beaver", color: Color.red),
                               QuizOption(id: 43, optionId: "C", option: "Capybara", color: Color.green),
                               QuizOption(id: 44, optionId: "D", option: "Prairie dog", color: Color.purple)]),
        
        QuizModel(question: "Most likely to end up in prison 😬",
                  answer: "A",
                  optionList: [QuizOption(id: 41, optionId: "A", option: "Eli", color: Color.yellow),
                               QuizOption(id: 42, optionId: "B", option: "Me", color: Color.red),
                               QuizOption(id: 43, optionId: "C", option: "Carson", color: Color.green),
                               QuizOption(id: 44, optionId: "D", option: "All the above", color: Color.purple)]),
        
        ]
    }
}
