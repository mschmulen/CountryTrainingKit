//
//  AgentSpeakingViewModel.swift
//  mini13
//
//  Created by Matthew Schmulen on 6/2/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation
import AVFoundation

internal class AgentSpeakingViewModel: NSObject {
    
    private let agentData: AgentData
    private let language: String
    
    // ------------------------------------------------
    // SpeechSynthesizer
    private let speechSynthesizer: AVSpeechSynthesizer
    
    /// defaultVolume: Range: 0.0 - 1.0 ; A relative volume to the device volume
    private let defaultVolume: Float = 0.8
    /// The baseline pitch at which the utterance will be spoken. range: 0.5 to 2.0
    private let defaultPitchMultiplier: Float = 1.2 //1.5
    
    /// When two or more utterances are spoken by an instance of AVSpeechSynthesizer, the time between periods when either is audible will be at least the sum of the first utterance’s postUtteranceDelay and the second utterance’s preUtteranceDelay.
    private let defaultPostUtteranceDelay = 0.1 // 2 seconds delay
    private let defaultPreUtteranceDelay = 0.2 // 2 seconds delay
    
    // must be betweent 0..<1.0
    public enum UtteranceRate {
        case fast
        case slow
        case normal
        
        var utterance_rate: Float {
            switch self {
            case .fast: return 0.7
            case .normal: return 0.5
            case .slow: return 0.25
            }
        }
    }
    // ------------------------------------------------
    
    public init(
        agent: AgentData,
        language: String
    ) {
        
        self.agentData = agent
        self.language = language
        self.speechSynthesizer = AVSpeechSynthesizer()
        
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.playAndRecord)
            try audioSession.setMode(AVAudioSession.Mode.spokenAudio)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)

            let currentRoute = AVAudioSession.sharedInstance().currentRoute
            for description in currentRoute.outputs {
                if description.portType == AVAudioSession.Port.headphones {
                    try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.none)
                    //print("headphone plugged in")
                } else {
                    //print("headphone pulled out")
                    try audioSession.overrideOutputAudioPort(AVAudioSession.PortOverride.speaker)
                }
            }
        } catch {
            print("audioSession properties weren't set because of an error.")
        }

        super.init()
    }
    
    private func playUtterance(
        utterance: String,
        speechSpeed utteranceRate: UtteranceRate = UtteranceRate.normal
    ){
        
        let utteranceLanguage:String
        switch language {
        case "en": utteranceLanguage = "English"
        case "fr": utteranceLanguage = "French"
        case "es": utteranceLanguage = "Spanish"
        case "it": utteranceLanguage = "Italian"
            // TODO: how about arabic and chinese ?
        default: utteranceLanguage = "English"
        }
        
        let voice = AVSpeechSynthesisVoice(language: utteranceLanguage)
        
        let utterance = AVSpeechUtterance(string: utterance)
        utterance.voice = voice
        utterance.volume = defaultVolume
        utterance.pitchMultiplier = defaultPitchMultiplier
        utterance.rate = utteranceRate.utterance_rate
        
//        utterance.preUtteranceDelay = defaultPreUtteranceDelay
//        utterance.postUtteranceDelay = defaultPostUtteranceDelay
        
        speechSynthesizer.speak(utterance)
    }
    
}

extension AgentSpeakingViewModel {

    public func expressGreeting(playerName: String) {
        playUtterance(
            utterance: agentData.greetingString(language: language, playerName: playerName)
        )
    }
    
    public func expressIntroduction(playerName: String) {
        playUtterance(
            utterance: agentData.IntroductionString(language: language, playerName: playerName)
        )
    }
    
    public func expressLetsGetStarted() {
        playUtterance(
            utterance: agentData.letsHaveSomeFunString(language: language)
        )
    }
    
    public func expressSuccess() {
        playUtterance(
            utterance: agentData.successString(language: language)
        )
    }
    
    public func expressFailure() {
        playUtterance(
            utterance: agentData.failureString(language: language)
        )
    }
    
    public func expressInstructions() {
        playUtterance(
            utterance: agentData.pickTheFlagForThisCountry(language: language)
        )
    }
    
    public func expressHelp( topic: String) {
        playUtterance(utterance: topic, speechSpeed: .normal)
    }
    
    public func sayWord(_ word: String) {
        playUtterance(utterance: word, speechSpeed: .normal)
    }
    
}
