//
//  FlagGameMLTrainingEvent.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/24/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

/// MLTrainingEvent: Outgoing training event to demonstrate and improve Agent reccomendations
internal struct FlagGameMLTrainingEvent: Codable {
    
    // data info
    var flagEmoji: String
    var countryName: String
    var predictedNumberOfGuesses: Double
    var acutalNumberOfGuesses: Double
    
    // player and device state info
    var playerNumberOfDaysOld: Double

    var localeCurrentRegionCode: String
    var localeCurrentLanguageCode: String
    // var localePreferredLanguages: [String]
    // device
    var deviceIdentifierForVendor: String
    var alternateLanguage: String
    
    public init(
      flagEmoji: String,
      countryName: String,
      predictedNumberOfGuesses: Double,
      acutalNumberOfGuesses: Double,

      playerNumberOfDaysOld: Double,
      
      localeCurrentRegionCode: String,
      localeCurrentLanguageCode: String,
      //localePreferredLanguages: [String],
      deviceIdentifierForVendor: String,
      alternateLanguage: String
    ) {
        self.flagEmoji = flagEmoji
        self.countryName = countryName
        self.predictedNumberOfGuesses = predictedNumberOfGuesses
        self.acutalNumberOfGuesses = acutalNumberOfGuesses

        self.playerNumberOfDaysOld = playerNumberOfDaysOld
        
        self.localeCurrentRegionCode = localeCurrentRegionCode
        self.localeCurrentLanguageCode = localeCurrentLanguageCode
        self.deviceIdentifierForVendor = deviceIdentifierForVendor
        self.alternateLanguage = alternateLanguage
    }

}

extension FlagGameMLTrainingEvent {
    
    static private let endpointURL = URL(string:"https://reqres.in/api/cupcakes")!
    
    internal func send(){
        // sendToServer()
        sendToCache()
    }
    
    private func sendToServer(){
        
        guard let encoded = try? JSONEncoder().encode(self) else {
            print("Failed to encode order")
            return
        }
        
        var request = URLRequest(url: FlagGameMLTrainingEvent.endpointURL)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            // handle the result here.
            
            guard let data = data else {
                print("No data in response: \(error?.localizedDescription ?? "Unknown error").")
                return
            }
            print( "data \(data)")
        }.resume()
        
    }//end sendToServer
    
    static var cachedEvents:[FlagGameMLTrainingEvent] = [FlagGameMLTrainingEvent]()
    
    private func sendToCache() {
        FlagGameMLTrainingEvent.cachedEvents.append (self)
    }
    
    private func csvRecord() -> String {
        // playerRegion,playerLanguage,playerAge,numberOfGuesses,countryFlagEmoji
        //return "\(self.playerRegion),\(self.playerLanguage),\(Double(22.0)),\(self.acutalNumberOfGuesses),\(self.flag)"
        
        // playerRegion,playerLanguage,playerAge,numberOfGuesses,countryFlagEmoji,deviceAlternateLanguage,deviceIdentifierForVendor
        return "\(self.localeCurrentRegionCode),\(self.localeCurrentLanguageCode),\(Double(22.0)),\(self.acutalNumberOfGuesses),\(alternateLanguage),\(deviceIdentifierForVendor),\(self.flagEmoji),\(self.countryName)"
    }
    
    internal static func dumpData() {
        for event in FlagGameMLTrainingEvent.cachedEvents {
            print(event.csvRecord())
        }
        //dumpFakeDataCountryTrainingEveryCountryGetsItsOwnVote(age: age)
        //dumpFakeDataCountryTrainingEveryCountryVoteForLanguage(age: age)
    }
    
    internal static func dumpFakeDataCountryTrainingEveryCountryGetsItsOwnVote(playerNumberOfDaysOld: Double) {
        
//        for country in IsoCountries.allCountries.shuffled() {
//            if let flag = country.flag {
//                let event = FlagGameMLTrainingEvent(
//                    flagEmoji: flag,
//                    name: country.name,
//                    predictedNumberOfGuesses: 1,
//                    acutalNumberOfGuesses: 1,
//                    playerNumberOfDaysOld: playerNumberOfDaysOld,
//                    localeCurrentRegionCode: country.alpha2,
//                    localeCurrentLanguageCode: country.officialLanguage,
//                    //localePreferredLanguages: [String](),
//                    deviceIdentifierForVendor: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF",
//                    deviceAlternateLanguage: "none"
//                )
//                print(event.csvRecord())
//            }
//        }
    }
    
    internal static func dumpFakeDataCountryTrainingEveryCountryVoteForLanguage(playerNumberOfDaysOld: Double) {
        
        // give an event of 1.9 for every country that has the french language
//        let targetGuesses = Double(1.9)
//
//        let randomCountry = ["FR","US","MX","CA","PA"]
//
//        let frenchSpeaking = IsoCountryCodes.searchByOfficialLanguage("fr")
//        for aCountry in frenchSpeaking {
//            if let flag = aCountry.flag {
//                let event = FlagGameMLTrainingEvent(
//                    flagEmoji: flag,
//                    name: aCountry.name,
//                    predictedNumberOfGuesses: targetGuesses,
//                    acutalNumberOfGuesses: targetGuesses,
//                    playerNumberOfDaysOld: playerNumberOfDaysOld,
//                    localeCurrentRegionCode: randomCountry.randomElement()!,
//                    localeCurrentLanguageCode: "fr",
//                    //localePreferredLanguages: [String](),
//                    deviceIdentifierForVendor: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF",
//                    deviceAlternateLanguage: "none"
//                )
//                print(event.csvRecord())
//            }
//        }
//
//        let enlishSpeaking = IsoCountryCodes.searchByOfficialLanguage("en")
//        for aCountry in enlishSpeaking {
//            if let flag = aCountry.flag {
//                let event = FlagGameMLTrainingEvent(
//                    flagEmoji: flag,
//                    name: aCountry.name,
//                    predictedNumberOfGuesses: targetGuesses,
//                    acutalNumberOfGuesses: targetGuesses,
//                    playerNumberOfDaysOld: playerNumberOfDaysOld,
//                    localeCurrentRegionCode: randomCountry.randomElement()!,
//                    localeCurrentLanguageCode: "en",
//                    //localePreferredLanguages: [String](),
//
//                    deviceIdentifierForVendor: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF",
//                    deviceAlternateLanguage: "none"
//                )
//                print(event.csvRecord())
//            }
//        }
//
//        let spanishSpeaking = IsoCountryCodes.searchByOfficialLanguage("es")
//        for aCountry in spanishSpeaking {
//            if let flag = aCountry.flag {
//                let event = FlagGameMLTrainingEvent(
//                    flagEmoji: flag,
//                    name: aCountry.name,
//                    predictedNumberOfGuesses: targetGuesses,
//                    acutalNumberOfGuesses: targetGuesses,
//                    playerNumberOfDaysOld: playerNumberOfDaysOld,
//                    localeCurrentRegionCode: randomCountry.randomElement()!,
//                    localeCurrentLanguageCode: "es",
//                    //localePreferredLanguages: [String](),
//
//                    deviceIdentifierForVendor: "FFFFFFFF-FFFF-FFFF-FFFF-FFFFFFFFFFFF",
//                    deviceAlternateLanguage: "none"
//                )
//                print(event.csvRecord())
//            }
//        }
    }
}
