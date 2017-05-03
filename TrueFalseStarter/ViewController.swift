//
//  ViewController.swift
//  TrueFalseStarter
//
//  Created by Pasan Premaratne on 3/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    let questionsPerRound = 10
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    
    var gameSound: SystemSoundID = 0
    
    let questionsAndAnswers = QuestionsAndAnswers()
    
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        // Start game
        playGameStartSound()
        displayQuestion()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayQuestion() {
        questionField.text = questionsAndAnswers.getQuestion()
        var questionDictionary = questionsAndAnswers.getQuestionAndAnswer()
        option1.setTitle(questionDictionary["option1"], for: UIControlState.normal)
        option2.setTitle(questionDictionary["option2"], for: UIControlState.normal)
        option3.setTitle(questionDictionary["option3"], for: UIControlState.normal)
        option4.setTitle(questionDictionary["option4"], for: UIControlState.normal)
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        option1.isHidden = true
        option2.isHidden = true
        option3.isHidden = true
        option4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }

    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        questionsAsked += 1
        
        
        let selectedQuestionDict = questionsAndAnswers.getQuestionAndAnswer()
        let correctAnswer = selectedQuestionDict["Answer"]
        
        switch sender{
            
            case option1:
                if(correctAnswer == selectedQuestionDict["option1"]){
                    correctQuestions += 1
                    questionField.text = "Correct!"
                } else{
                    questionField.text = "Sorry, wrong answer!"
                }
            case option2:
                if(correctAnswer == selectedQuestionDict["option2"]){
                    correctQuestions += 1
                    questionField.text = "Correct!"
                } else{
                    questionField.text = "Sorry, wrong answer!"
                }
            case option3:
                if(correctAnswer == selectedQuestionDict["option3"]){
                    correctQuestions += 1
                    questionField.text = "Correct!"
                } else{
                    questionField.text = "Sorry, wrong answer!"
                }
            case option4:
                if(correctAnswer == selectedQuestionDict["option4"]){
                    correctQuestions += 1
                    questionField.text = "Correct!"
                } else{
                    questionField.text = "Sorry, wrong answer!"
                }
            default: break
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func nextRound() {
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        option1.isHidden = false
        option2.isHidden = false
        option3.isHidden = false
        option4.isHidden = false
        
        
        questionsAsked = 0
        correctQuestions = 0
        questionsAndAnswers.checkQuestions = []
        nextRound()
    }
    

    
    // MARK: Helper Methods
    
    func loadNextRoundWithDelay(seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func loadGameStartSound() {
        let pathToSoundFile = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundURL = URL(fileURLWithPath: pathToSoundFile!)
        AudioServicesCreateSystemSoundID(soundURL as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
}

