//
//  GameAgentViewModel+Speaking.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/24/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

// MARK:- Speaking Services
extension CountryTeacherAgentViewModel {
    
    public func expressGreeting(playerName: String) {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.expressGreeting(playerName: playerName)
        }
    }
    
    public func expressIntroduction(playerName: String) {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.expressIntroduction(playerName: playerName)
        }
    }
    
    public func expressLetsGetStarted() {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.expressLetsGetStarted()
        }
    }
    
    public func expressSuccess() {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.expressSuccess()
        }
    }
    
    public func expressFailure() {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.expressFailure()
        }
    }
    
    public func expressInstructions() {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.expressInstructions()
        }
        
    }
    
    public func expressHelp( topic: String) {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.expressHelp(topic: topic)
        }
    }
    
    public func sayWord( _ word: String) {
        if agentData.enableVoiceOver {
            agentSpeakingViewModel.sayWord(word)
        }
    }
    
}
