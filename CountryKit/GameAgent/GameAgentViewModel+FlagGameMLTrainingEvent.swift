//
//  GameAgentViewModel+MachineLearningEvent.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/24/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

// TODO GameAgentViewModel MachineLearningEvent
// MARK:- FlagGameMLTrainingEvent
extension CountryTeacherAgentViewModel {
    
    public func dispatchMachineLearningEventToServer(
        gameResult: CountryTrainingKit.FlagGameResult
    ) {
           let mlTrainingEvent = FlagGameMLTrainingEvent(
               flagEmoji: gameResult.flagEmoji,
               countryName: gameResult.countryName,
               predictedNumberOfGuesses: gameResult.predictedNumberOfGuesses,
               acutalNumberOfGuesses: gameResult.acutalNumberOfGuesses,
               playerNumberOfDaysOld: playerNumberOfDaysOld,
               localeCurrentRegionCode: localeCurrentLanguageCode,
               localeCurrentLanguageCode: localeCurrentRegionCode,               
               deviceIdentifierForVendor: deviceIdentifierForVendor,
               alternateLanguage: alternateLanguage
           )
           mlTrainingEvent.send()
           // playerData.playerAge
       }// dispatchMachineLearningEventToServer
    
    public func dumpData() {
        FlagGameMLTrainingEvent.dumpData()
    }
    
}
