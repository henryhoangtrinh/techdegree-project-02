//
//  QuizManager.swift
//  EnhanceQuizStarter
//
//  Created by Henry Trinh on 6/11/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit
import GameKit

class QuizManager {
    
    var questionsAsked = 0
    var questionsPerRound = 4
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var randomNumberGenerated = [Int]()
    
    
    
    var questions: [[String:String]] = [
        ["Question":"Who owns the Infinity Gauntlet?", "Answer":"Thanos"],//1. Thanos
        ["Question":"How many Infinity Stones in total?", "Answer":"6"], //2. 6
        ["Question":"Which one is Thor's weapon?", "Answer":"StormBreaker"], //3. StormBreaker
        ["Question":"Who could lift Mjolnir Hammer beside Thor?", "Answer":"Captian American"], //4. Captian American
        ["Question":"Who died at the end of EndGame?", "Answer":"Tony Stark"], //5. Tony Stark
        ["Question":"Who is the Captian Rabbit in EndGame?", "Answer":"Rocket Racoon"], //6. Rocket Raccon
        ["Question":"What happened to Thanos at the beginning of EngGame?", "Answer":"Killed by Thor"], //7. killed by Thor
        ["Question":"What is the Star-lord's spaceship name?", "Answer":"Milano"], //8. Milano
        ["Question":"What is Iron Man love to eat the most?", "Answer":"CheeseBurger"], //9. Cheeseburger
        ["Question":"With full power, how much weight Iron man suit can lift", "Answer":"200,000 lbs"], //200,000 lbs
        ["Question":"Who is the first person figure out the way to solve Thanos snap?", "Answer":"Ant Man"], //11 Ant Man
        ["Question":"Who is the one actually make the time travel become reality?", "Answer":"Iron Man"], //12 Iron man
        // Question with 3 choices
        ["Question": "What is the name of the war in EndGames?" , "Answer" : "Infinity war"],
        ["Question": "How many possible future timelines when Dr. Strange peers into the future?", "Answer" : "14,000,605"],
        ["Question": "As Dr. Strange said, how many chances Avangers could win the war?", "Answer" : "1"],
        ["Question": "Who plays the role as Dr. Strange?", "Answer" : "Benedict Cumberbatch"],
        // Question with 2 choices
        ["Question" : "Thanos defeated The Avangers in the Infinity war?", "Answer" : "True"],
        ["Question" : "Did Spider Man mess up plan of stealing Infinity Gauntlet from Thanos", "Answer" : "False"],
        ["Question" : "Iron Man is Peter Parker's father?", "Answer" : "False"],
        ["Question" : "Hulk became Professor Hulk in the EndGame?", "Answer" : "True"]
    ]
    
    var answers: [[String]] = [
        ["Thanos","Quil","Spider Man","Captain Marvel"], //1
        ["1","3","6","9"], //2
        ["Hurican","Lich","Infinity Hammer","StormBreaker"], //3
        ["The Hulk","Captian American","Captian Marvel","Iron man"], //4
        ["Peter Quill","Eitri","Thor","Tony Stark"], //5
        ["Groot","Rocker","Rocket Racoon","Gamora"], //6
        ["Killed by Thor","Become god of whole galaxy","Stay in Earth","Unknown"], //7
        ["Mallanio","Faccon","Milano","Egor"], //8
        ["Pizza","Ramen","Oil","CheeseBurger"], //9
        ["200,000 lbs","500,000 lbs","1,000,000 lbs","2,000,000 lbs"], //10
        ["Thanos","Ant Man","Iron Man","The Hulk"], //11
        ["Thanos","Ant Man","Iron Man","The Hulk"], //12
        // 3 choices
        ["Civil war","Infinity war","World war"],
        ["14,000,000","14,605,000","14,000,605"],
        ["1","10","100"],
        ["Chris Evens","Benedict Cumberbatch","Robert Downey Jr."],
        // T/F
        ["True","False"],
        ["True","False"],
        ["True","False"],
        ["True","False"]
    ]
    
    var allQuestions: [QuizObject] = []
    
    init() {
        for a in 0..<questions.count {
            let trivia = QuizObject(question: questions[a],answer : answers[a])
            allQuestions.append(trivia)
        }
    }
    
    func generateUnquieNumber()-> Int {
        
        var shuffleQuestions = GKRandomSource.sharedRandom().nextInt(upperBound: self.allQuestions.count)
        while randomNumberGenerated.contains(shuffleQuestions) {
            shuffleQuestions = GKRandomSource.sharedRandom().nextInt(upperBound: self.allQuestions.count)
        }
        
        randomNumberGenerated.append(shuffleQuestions)
        return shuffleQuestions
    }
    
    // MARK: Random questionselection
    func randomQuestion() -> QuizObject {
        let genneratedQuestion = allQuestions[generateUnquieNumber()]
        return genneratedQuestion
    }
    
}
