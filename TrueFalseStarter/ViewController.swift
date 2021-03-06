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
    var selectedQuestionDict = ["": ""]
    var correctAnswer: String = ""
    var timeLeft = 15 // for the timer
    var myTimer: Timer!
    
    
    var gameSound: SystemSoundID = 0
    var correctAnswerSound: SystemSoundID = 1
    var wrongAnswerSound: SystemSoundID = 2
    
    let questionsAndAnswers = QuestionsAndAnswers()
    
    
    @IBOutlet weak var correction: UILabel! // to show the correct answer if the user chose the wrong answer
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var option1: UIButton! // answer 1
    @IBOutlet weak var option2: UIButton! // answer 2
    @IBOutlet weak var option3: UIButton! // answer 3
    @IBOutlet weak var option4: UIButton! // answer 4
    @IBOutlet weak var time: UILabel! // label (Time)
    @IBOutlet weak var nextQuestionButton: UIButton! // next question button
    @IBOutlet weak var timeLeftLabel: UILabel! // time left in numbers
    

    
    

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
        
        if questionsAsked > 0 {      // this if statement is used to reset the timer, so it doesnt go fast after the first quetion.
            print(questionsAsked)
            myTimer.invalidate()
        }

        
        questionField.text = questionsAndAnswers.getQuestion()
        var questionDictionary = questionsAndAnswers.getQuestionAndAnswer()
        option1.setTitle(questionDictionary["option1"], for: UIControlState.normal)
        option2.setTitle(questionDictionary["option2"], for: UIControlState.normal)
        option3.setTitle(questionDictionary["option3"], for: UIControlState.normal)
        option4.setTitle(questionDictionary["option4"], for: UIControlState.normal)
        playAgainButton.isHidden = true
        nextQuestionButton.isHidden = true
        correction.isHidden = true
        
        timeLeft = 15
        myTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(ViewController.timerRunning), userInfo: nil, repeats: true)
    }
    
    func timerRunning() {
        timeLeft -= 1
        time.text = String(timeLeft)
        
        if timeLeft == 0 { // if timer is equal to zero then hide all disable all answers and show next question button
            AudioServicesPlaySystemSound(wrongAnswerSound)
            myTimer.invalidate()
            option1.isEnabled = false
            option2.isEnabled = false
            option3.isEnabled = false
            option4.isEnabled = false
            
            selectedQuestionDict = questionsAndAnswers.getQuestionAndAnswer()
            correctAnswer = selectedQuestionDict["Answer"]!
            correctWrongAnswer(correctAnswer: correctAnswer)
            
            
            if questionsAsked == 9 {  // if this is the last question then hide next question button and show score
                nextQuestionButton.isHidden = true
                questionsAsked += 1
                //loadNextRoundWithDelay(seconds: 2)
                nextRound()
            } else{
                nextQuestionButton.isHidden = false
            }
        }
        
    }
    
    func displayScore() {
        // Hide the answer buttons
        option1.isHidden = true
        option2.isHidden = true
        option3.isHidden = true
        option4.isHidden = true
        
        // Display play again button
        playAgainButton.isHidden = false
        nextQuestionButton.isHidden = true
        correction.isHidden = true
        timeLeftLabel.isHidden = true
        time.isHidden = true
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
        
    }

    @IBAction func checkAnswer(_ sender: UIButton) {
        // Increment the questions asked counter
        
        myTimer.invalidate()
        questionsAsked += 1
        
        
        selectedQuestionDict = questionsAndAnswers.getQuestionAndAnswer()
        correctAnswer = selectedQuestionDict["Answer"]!
        
        option1.isEnabled = false
        option2.isEnabled = false
        option3.isEnabled = false
        option4.isEnabled = false
        
        switch sender{
            
            case option1:
                option1.isEnabled = true
                if(correctAnswer == selectedQuestionDict["option1"]){
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    correctWrongAnswer(correctAnswer: "Correct!")
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    //questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer)
                }
            case option2:
                option2.isEnabled = true
                if(correctAnswer == selectedQuestionDict["option2"]){
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    correctWrongAnswer(correctAnswer: "Correct!")
                    AudioServicesDisposeSystemSoundID(1)
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    //questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer)
                    
                }
            case option3:
                option3.isEnabled = true
                if(correctAnswer == selectedQuestionDict["option3"]){
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    correctWrongAnswer(correctAnswer: "Correct!")
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    //questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer)
                }
            case option4:
                option4.isEnabled = true
                if(correctAnswer == selectedQuestionDict["option4"]){
                    AudioServicesPlaySystemSound(correctAnswerSound)
                    correctQuestions += 1
                    correctWrongAnswer(correctAnswer: "Correct!")
                    AudioServicesDisposeSystemSoundID(1)
                } else{
                    AudioServicesPlaySystemSound(wrongAnswerSound)
                    //questionField.text = "Sorry, wrong answer!"
                    correctWrongAnswer(correctAnswer: correctAnswer)
                    
                }
            default: break
        }
        
        loadNextRoundWithDelay(seconds: 2)
    }
    
    func correctWrongAnswer(correctAnswer: String) {
        correction.text = correctAnswer
        if correctAnswer == "Correct!" {
            correction.textColor = UIColor(red: 47/255.0, green: 179/255.6, blue: 171/255.0, alpha: 1.0)
        } else {
            correction.textColor = UIColor(red: 254/255.0, green: 168/255.6, blue: 41/255.0, alpha: 1.0)
        }
        correction.isHidden = false
    }
    
    func nextRound() {
        
        option1.isEnabled = true
        option2.isEnabled = true
        option3.isEnabled = true
        option4.isEnabled = true
        
        if questionsAsked == questionsPerRound {
            // Game is over
            displayScore()
        } else {
            // Continue game
            displayQuestion()
        }
    }
    
    
    @IBAction func nextQuestion() {
        questionsAsked += 1
        option1.isEnabled = true
        option2.isEnabled = true
        option3.isEnabled = true
        option4.isEnabled = true
        nextRound()
    }
    
    @IBAction func playAgain() {
        // Show the answer buttons
        timeLeft = 5
        option1.isHidden = false
        option2.isHidden = false
        option3.isHidden = false
        option4.isHidden = false
        correction.isHidden = true
        timeLeftLabel.isHidden = false
        time.isHidden = false
        
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

