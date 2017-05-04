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
    
    //var timer: Timer = Timer.scheduledTimer(withTimeInterval: 15, repeats: true, block: <#T##(Timer) -> Void#>)
    
    let questionsPerRound = 10
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion: Int = 0
    
    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    
    let questionsAndAnswers = QuestionsAndAnswers()
    
    
    @IBOutlet weak var correction: UILabel! // to show the correct answer if the user chose the wrong answer
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option1: UIButton!
    @IBOutlet weak var option2: UIButton!
    @IBOutlet weak var option3: UIButton!
    @IBOutlet weak var option4: UIButton!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        loadGameStartSound()
        loadWrongAnswerSound()
        loadCorrectAnswerSound()

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
        correction.isHidden = true
    }
    
    func displayScore() {
        // Hide the answer buttons
        option1.isHidden = true
        option2.isHidden = true
        option3.isHidden = true
        option4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        correction.isHidden = true
        
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
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    questionField.text = "Correct!"
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer!)
                }
            case option2:
                if(correctAnswer == selectedQuestionDict["option2"]){
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    questionField.text = "Correct!"
                    AudioServicesDisposeSystemSoundID(1)
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer!)
                    
                }
            case option3:
                if(correctAnswer == selectedQuestionDict["option3"]){
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    questionField.text = "Correct!"
                    AudioServicesDisposeSystemSoundID(1)
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer!)
                }
            case option4:
                if(correctAnswer == selectedQuestionDict["option4"]){
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    questionField.text = "Correct!"
                    AudioServicesDisposeSystemSoundID(1)
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer!)
                    
                }
            default: break
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func correctWrongAnswer(correctAnswer: String) {
        let rightAnswerMessage = "Correct Answer is: \(correctAnswer)"
        correction.text = rightAnswerMessage
        correction.isHidden = false
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
        correction.isHidden = true
        
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
    
    
    func loadCorrectAnswerSound(){
        let pathToSoundFile1 = Bundle.main.path(forResource: "CorrectAnswer", ofType: "wav")
        let soundURL1 = URL(fileURLWithPath: pathToSoundFile1!)
        AudioServicesCreateSystemSoundID(soundURL1 as CFURL, &correctAnswerSound)
    }
    func loadWrongAnswerSound() {
        let pathToSoundFile2 = Bundle.main.path(forResource: "WrongAnswer", ofType: "wav")
        let soundURL2 = URL(fileURLWithPath: pathToSoundFile2!)
        AudioServicesCreateSystemSoundID(soundURL2 as CFURL, &wrongAnswerSound)
    }
}

