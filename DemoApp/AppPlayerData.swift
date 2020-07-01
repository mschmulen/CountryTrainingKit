//
//  CountryPlayerData.swift
//  DemoApp
//
//  Created by Matthew Schmulen on 6/17/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

struct AppPlayerData {

    var playerName: String
    
    var localeCurrentLanguageCode: String
    var localeCurrentRegionCode: String
    
    var alternateLanguage: String
//    var alternateLanguage2: String
//    var alternateLanguage3: String

    
    var playerNumberOfDaysOld: Double
    
    var devicePreferredLanguages: [String]
    
    var deviceIdentifierForVendor: String
    
    static var mockUS: AppPlayerData {
        return AppPlayerData(
            playerName: "Bobby",
            localeCurrentLanguageCode: "en",
            localeCurrentRegionCode: "US",
            alternateLanguage: "none",
            playerNumberOfDaysOld: Double(9400), // ~36 years old
            devicePreferredLanguages: [String](),
            deviceIdentifierForVendor: UUID().uuidString
        )
    }
    
    static var mockRandom: AppPlayerData {
        let playerName = "Randy_\(Int.random(in: 1...100))"
        
        let randomDayAge = [
            Double(3400),      // ~9 years old
            Double(5400),
            Double(8400),
            Double(8400),
            Double(9400)        // ~36 years old
        ]
        
        let randomCountry = [
            "US",
            "FR",
            "MX",
            "CA",
            "PA",   // panama
            "DE",   // germany
            "PL"    // poland
        ]
        
        let randomLanguage = [
            "en",
            "es",
            "fr",
            "zh", // chinese
            "pt", // portugese
            "de", // german
            "ar", // arabic
            "pl", // polish
            "it"
        ]
        
        let preferredLanguages = [String]()
        
        return AppPlayerData(
            playerName: playerName,
            localeCurrentLanguageCode: randomLanguage.randomElement()!,
            localeCurrentRegionCode: randomCountry.randomElement()!,
            alternateLanguage: "none",
            playerNumberOfDaysOld: randomDayAge.randomElement()!,
            devicePreferredLanguages: preferredLanguages,
            deviceIdentifierForVendor: UUID().uuidString
        )
    }
}
