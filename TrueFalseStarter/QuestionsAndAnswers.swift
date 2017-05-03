//
//  QuestionsAndAnswers.swift
//  TrueFalseStarter
//
//  Created by youssef yacoub on 2017-05-02.
//  Copyright © 2017 Treehouse. All rights reserved.
//

import GameKit

class QuestionsAndAnswers{
    
    var indexOfSelectedQuestion: Int
    var checkQuestions: [Int] // empty array used to check duplicate questions

    let trivia: [[String : String]] = [
        ["Question": "This was the only US President to serve more than two consecutive terms.", "option1": "George Washington", "option2": "Franklin D. Roosevelt", "option3": "Woodrow Wilson", "option4": "Andrew Jackson", "Answer": "Franklin D. Roosevelt"],
        ["Question": "Which of the following countries has the most residents?", "option1": "Nigeria", "option2": "Russia", "option3": "Iran", "option4": "Vietnam", "Answer": "Nigeria"],
        ["Question": "In what year was the United Nations founded?", "option1": "1918", "option2": "1919", "option3": "1945", "option4": "1954", "Answer": "1945"],
        ["Question": "The Titanic departed from the United Kingdom, where was it supposed to arrive?", "option1": "Paris", "option2": "Washington D.C.", "option3": "New York City", "option4": "Boston", "Answer": "New York City"],
        ["Question": "Which nation produces the most oil?", "option1": "Iran", "option2": "Iraq", "option3": "Brazil", "option4": "Canada", "Answer": "Canada"],
        ["Question": "Which country has most recently won consecutive World Cups in Soccer?", "option1": "Italy", "option2": "Brazil", "option3": "Argetina", "option4": "Spain", "Answer": "Brazil"],
        ["Question": "Which of the following rivers is longest?", "option1": "Yangtze", "option2": "Mississippi", "option3": "Congo", "option4": "Mekong", "Answer": "Mississippi"],
        ["Question": "Which city is the oldest?", "option1": "Mexico City", "option2": "Cape Town", "option3": "San Juan", "option4": "Sydney", "Answer": "Mexico City"],
        ["Question": "Which country was the first to allow women to vote in national elections?", "option1": "Poland", "option2": "United States", "option3": "Sweden", "option4": "Senegal", "Answer": "Poland"],
        ["Question": "Which of these countries won the most medals in the 2012 Summer Games?", "option1": "France", "option2": "Germany", "option3": "Japan", "option4": "Great Britian", "Answer": "Great Britian"]
    ]
    
    init() {
        self.indexOfSelectedQuestion = 0
        self.checkQuestions = []
    }
    
    
    func getQuestion() -> String{
        var question: String = ""
        repeat{
            indexOfSelectedQuestion = GKRandomSource.sharedRandom().nextInt(upperBound: trivia.count)
            if !(checkQuestions.contains(indexOfSelectedQuestion)){
               
                let questionDictionary = trivia[indexOfSelectedQuestion]
                question = questionDictionary["Question"]!
           }
        }while(checkQuestions.contains(indexOfSelectedQuestion))
        checkQuestions.append(indexOfSelectedQuestion)
        return question
    }
    
    func getQuestionAndAnswer() -> [String: String]{
        return trivia[indexOfSelectedQuestion]
    }


}
