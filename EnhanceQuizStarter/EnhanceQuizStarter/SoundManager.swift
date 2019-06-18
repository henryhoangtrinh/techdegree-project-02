//
//  SoundManager.swift
//  EnhanceQuizStarter
//
//  Created by Henry Trinh on 6/17/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import AudioToolbox

struct SoundManager {
    
    var gameSound: SystemSoundID = 0
    
    
    mutating func loadCorrectSound() {
        let correctSound = Bundle.main.path(forResource: "correct", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: correctSound!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    mutating func loadIncorrectSound() {
        let incorrectSound = Bundle.main.path(forResource: "wrong", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: incorrectSound!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    mutating func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
}
