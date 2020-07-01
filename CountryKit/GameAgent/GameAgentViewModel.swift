//
//  AgentViewModel.swift
//  CountryKit
//
//  Created by Matthew Schmulen on 6/11/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

public typealias FlagGameNumberOfGuesses = Double // 0to 1

// TODO rename GameAgentViewModel, make it private ?
public class CountryTeacherAgentViewModel: NSObject{
    
    public enum AgentError: Error {
        case unknown
    }
    
    internal let playerNumberOfDaysOld: Double
    internal let localeCurrentLanguageCode: String
    internal let localeCurrentRegionCode: String
    internal let alternateLanguage: String
    internal let deviceIdentifierForVendor: String
    
    internal let agentData: AgentData
    internal let agentSpeakingViewModel: AgentSpeakingViewModel
    internal let coreMLModel = CountryFlagGameRegressor()
    
    public required init(
        agent: AgentData,
        localeCurrentLanguageCode: String,
        localeCurrentRegionCode: String,
        alternateLanguage: String,
        deviceIdentifierForVendor: String,
        playerNumberOfDaysOld: Double
    ) {
        self.agentData = agent
        self.localeCurrentLanguageCode = localeCurrentLanguageCode
        self.localeCurrentRegionCode = localeCurrentRegionCode
        self.alternateLanguage = alternateLanguage
        self.deviceIdentifierForVendor = deviceIdentifierForVendor
        self.playerNumberOfDaysOld = playerNumberOfDaysOld
        
        self.agentSpeakingViewModel = AgentSpeakingViewModel(
            agent: agent,
            language: localeCurrentLanguageCode
        )
    }
}

// MARK:- Flag Games Generator
extension CountryTeacherAgentViewModel {
    /**
     generateFlagProblem:
     Can you generate a flag problem where the user has a 50% chance of getting it right
     - regardless of age 5 to 50
     - regarless of language
     - regarless of location
     */
    public func generateChallenge(
        deviceAlternateLanguage: String, // TODO fix this 
        pastGameResults: [FlagGameResult],
        numberOfAlternates: Int = 5
    ) throws -> FlagGamePickerDataModel {
        
        switch agentData.agentType {
        case .ml:
            return try coreMLGeneratedFlagChallenge(
                playerLanguage: localeCurrentLanguageCode,
                playerRegion: localeCurrentRegionCode,
                playerNumberOfDaysOld: playerNumberOfDaysOld,
                deviceAlternateLanguage: deviceAlternateLanguage,
                pastGameResults: pastGameResults,
                numberOfAlternates: numberOfAlternates
            )
        case .random:
            return try randomGeneratedFlagChallenge(
                playerLanguage: localeCurrentLanguageCode,
                playerRegion: localeCurrentRegionCode,
                playerNumberOfDaysOld: playerNumberOfDaysOld,
                deviceAlternateLanguage: deviceAlternateLanguage,
                pastGameResults: pastGameResults,
                numberOfAlternates: numberOfAlternates
            )
        }
    }
}
