//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    var gameSound: SystemSoundID = 0
    let trivia = QuizManager()
    var allQuestions: QuizObject! = nil
    var seconds = 15.0
    var timer = Timer()
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var trueButton: UIButton!
    @IBOutlet weak var falseButton: UIButton!
    @IBOutlet weak var Question3: UIButton!
    @IBOutlet weak var Question4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet var TimerCountdown: UILabel!
    
    func setCountdown() {
        seconds = 15
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(testcountdown), userInfo: nil, repeats: true)
    }
   
    
    @objc func testcountdown(){
        seconds -= 0.1
        TimerCountdown.text = String(format: "%.1f", seconds)
        if seconds <= 0  {
            timer.invalidate()
            TimerCountdown.text = "0.0"
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setCountdown()
        loadGameStartSound()
        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadCorrectSound() {
        let correctSound = Bundle.main.path(forResource: "correct", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: correctSound!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func loadIncorrectSound() {
        let incorrectSound = Bundle.main.path(forResource: "wrong", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: incorrectSound!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func displayQuestion() {
        allQuestions = trivia.randomQuestion()
        questionField.text = allQuestions.question["Question"]
        let choices = allQuestions.answer
        if allQuestions.answer.count == 2 {
            trueButton.setTitle(choices[0], for: [])
            falseButton.setTitle(choices[1], for: [])
            
            trueButton.isHidden = false
            falseButton.isHidden = false
            Question3.isHidden = true
            Question4.isHidden = true
      
        } else if allQuestions.answer.count == 3 {
            trueButton.setTitle(choices[0], for: [])
            falseButton.setTitle(choices[1], for: [])
            Question3.setTitle(choices[2], for: [])
            
            trueButton.isHidden = false
            falseButton.isHidden = false
            Question3.isHidden = false
            Question4.isHidden = true
        
        } else if allQuestions.answer.count == 4 {
            trueButton.setTitle(choices[0], for: [])
            falseButton.setTitle(choices[1], for: [])
            Question3.setTitle(choices[2], for: [])
            Question4.setTitle(choices[3], for: [])
            
            trueButton.isHidden = false
            falseButton.isHidden = false
            Question3.isHidden = false
            Question4.isHidden = false
        }
    
        trueButton.isEnabled = true
        falseButton.isEnabled = true
        Question3.isEnabled = true
        Question4.isEnabled = true
        playAgainButton.isHidden = true
        
        
    }
    
    func displayScore() {
        // Hide the answer buttons
        seconds = 15
        TimerCountdown.text = "\(seconds)"
        trueButton.isHidden = true
        falseButton.isHidden = true
        Question3.isHidden = true
        Question4.isHidden = true
        // Display play again button
        playAgainButton.isHidden = false
        //questionField.text = ""
        
        questionField.text = "Way to go!\nYou got \(trivia.correctQuestions) out of \(trivia.questionsPerRound) correct!"
      
    }
    
    func nextRound() {
        if trivia.questionsAsked == trivia.questionsPerRound {
            // Game is over
            displayScore()
             //displayQuestion()
        } else {
            // Continue game
            displayQuestion()
            setCountdown()
        }
    }
    
   func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        if seconds > 0 {
            trivia.questionsAsked += 1
            let correctAnswer = allQuestions.question["Answer"]
            let choices = allQuestions.answer
           // check each answer and added the sound effect when pressed the corrected or incorrected answer
           // Also, added the Lighting mode when the timer hit 0.0 the answer will NOT be counted
            if (sender === trueButton &&  correctAnswer == choices[0]) || (sender === falseButton && correctAnswer == choices[1]) || (sender === Question3 &&  correctAnswer == choices[2]) || (sender === Question4 &&  correctAnswer == choices[3]) {
                trivia.correctQuestions += 1
                  questionField.text = "Correct!"
                TimerCountdown.text = "\(seconds)"
                timer.invalidate()
                loadCorrectSound()
                playGameStartSound()
            } else {
                questionField.text = "The correct answer: " + allQuestions.question["Answer"]!
                timer.invalidate()
                loadIncorrectSound()
                playGameStartSound()
            }
        } else if seconds <= 0 {
            trivia.questionsAsked += 1
            questionField.text = "Sorry, Timeout! Your answer isn't counted"
        }
        timer.invalidate()
        loadNextRound(delay: 5)
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        allQuestions = trivia.randomQuestion()
        setCountdown()
        if allQuestions.answer.count == 2 {
            trueButton.isHidden = false
            falseButton.isHidden = false
            Question3.isHidden = true
            Question4.isHidden = true
        } else if allQuestions.answer.count == 3 {
            trueButton.isHidden = false
            falseButton.isHidden = false
            Question3.isHidden = false
            Question4.isHidden = true
        } else if allQuestions.answer.count == 4 {
            trueButton.isHidden = false
            falseButton.isHidden = false
            Question3.isHidden = false
            Question4.isHidden = false
        }
            trivia.questionsAsked = 0
            trivia.correctQuestions = 0
            displayQuestion()
    }
}

