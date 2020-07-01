//
//  AgentViewModel+ML.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/24/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

extension CountryTeacherAgentViewModel {
    
    internal func coreMLGeneratedFlagChallenge(
        playerLanguage: String,
        playerRegion: String,
        playerNumberOfDaysOld: Double,
        deviceAlternateLanguage: String,
        pastGameResults: [FlagGameResult],
        numberOfAlternates: Int
    ) throws -> FlagGamePickerDataModel {
        
        // map to just the raw emoji
        let pastSessionFlags:[String] = pastGameResults.map { (session) -> String in
            return session.flagEmoji
        }
        
        // remove the perfect sessions
        var availableFlags:[String]  = IsoCountries.allCountries.compactMap { $0.flag }
        availableFlags = availableFlags.filter { (flagEmoji) -> Bool in
            if pastSessionFlags.contains(flagEmoji) {
                return false
            } else {
                return true
            }
        }
        
        // remove the current sessions from the inventory
        let filteredInventoryList = IsoCountries.allCountries.filter({ (model) -> Bool in
            if let flagEmoji = model.flag {
                if pastSessionFlags.contains(flagEmoji) {
                    return false
                } else {
                    return true
                }
            }
            return true
        })
        
        var mlResults = fetchMLPredictionList(
            playerRegion: playerRegion,
            playerLanguage: playerLanguage,
            playerNumberOfDaysOld: playerNumberOfDaysOld,
            deviceAlternateLanguage: deviceAlternateLanguage,
            countryList: filteredInventoryList
        )
        
        mlResults.sort { (a, b) -> Bool in
            // highest to lowest
            a.numberOfGuesses >= b.numberOfGuesses
        }
        
        // reverse so the lowest guess is the first in the list
        mlResults.reverse()
        
        // this would be more interesting if you took the players average pick count and tried to index into the array at that location ... maybe later
        guard let countryChallenge = mlResults.first else {
            throw AgentError.unknown
        }
        // remove the current challenge from the list
        mlResults.removeAll { (model) -> Bool in
            countryChallenge.flag == model.flag
        }
        
        // generate alternates
        var alternatesList = [ModelPrediction]()
        for _ in 0..<numberOfAlternates {
            if let alternateCountry = mlResults.randomElement() {
                alternatesList.append(alternateCountry)
                mlResults.removeAll { (isoCountryInfo) -> Bool in
                    alternateCountry.flag == isoCountryInfo.flag
                }
            } else {
                throw AgentError.unknown
            }
        }
        
        // transform from FlagPickerDataModel.SimplifiedFlagModel
        let alternateCountryDataModels:[FlagGamePickerDataModel.SimplifiedFlagModel] = alternatesList.map{ (model) -> FlagGamePickerDataModel.SimplifiedFlagModel in
            return FlagGamePickerDataModel.SimplifiedFlagModel(
                id: UUID(),
                name: model.name,
                flagEmoji: model.flag
            )
        }
        
        // output result model
        let resultModel = FlagGamePickerDataModel(
            title: countryChallenge.name,
            answer: FlagGamePickerDataModel.SimplifiedFlagModel(
                id: UUID(),
                name: countryChallenge.name,
                flagEmoji: countryChallenge.flag
            ),
            alternates: alternateCountryDataModels,
            predictedNumberOfGuesses: countryChallenge.numberOfGuesses // lock to 0.5 since its random
        )
        
        return resultModel
    }
}

// MARK:- Flag Games Generator
extension CountryTeacherAgentViewModel {
    
    struct ModelPrediction {
        var flag: String
        var name: String
        var numberOfGuesses: Double
    }
    
    // TODO calcualte the list based on the ML ranking
    internal func fetchMLPredictionList(
        playerRegion:String,
        playerLanguage:String,
        playerNumberOfDaysOld:Double,
        deviceAlternateLanguage:String,
        countryList: [IsoCountryInfo]
    ) -> [ModelPrediction] {
        
        var returnResults = [ModelPrediction]()
        
        do {
            for country in countryList.shuffled() {
                let flag = country.flag!
                let prediction = try coreMLModel.prediction(
                    playerRegion: playerRegion,
                    playerLanguage: playerLanguage,
                    playerNumberOfDaysOld: playerNumberOfDaysOld,
                    countryFlagEmoji: flag,
                    deviceAlternateLanguage: deviceAlternateLanguage
                )
                
                let result = ModelPrediction(
                    flag: flag,
                    name: country.name,
                    numberOfGuesses: prediction.numberOfGuesses
                )
                returnResults.append( result )
            }
        } catch let error {
            print( "calculateML.error \(error)")
        }
        
        return returnResults
    }
    
    
}
