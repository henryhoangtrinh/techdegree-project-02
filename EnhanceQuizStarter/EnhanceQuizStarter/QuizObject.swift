//
//  QuizObject.swift
//  EnhanceQuizStarter
//
//  Created by Henry Trinh on 6/11/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import UIKit

struct QuizObject {
    var question: [String:String] //Dictionary for Questions with answer inclued
    var answer: [String] //Collection of answers
    
    
    init(question: [String:String], answer: [String]){
        self.question = question
        self.answer = answer    
    }
}

