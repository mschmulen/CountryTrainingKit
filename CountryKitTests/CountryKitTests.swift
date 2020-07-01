//
//  CountryKitTests.swift
//  CountryKitTests
//
//  Created by Matthew Schmulen on 6/11/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import XCTest
@testable import CountryTrainingKit

class CountryKitTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension CountryKitTests {
    
    func test_US_en() throws {
        // TODO check if the US flag is in the top 5
        
        let language = "en"
        let region = "US"
        let alternateLanguage = "none"

        let agentData = AgentData(agentType: .ml, enableVoiceOver: false)
        
        let agentViewModel = CountryTeacherAgentViewModel(
            agent: agentData,
            playerLanguage: language,
            playerRegion: region,
            playerNumberOfDaysOld: nil
        )
        
        let challenge = try! agentViewModel.generateChallenge(
            playerLanguage: language,
            playerRegion: region,
            playerNumberOfDaysOld: Double(4000),
            deviceAlternateLanguage: alternateLanguage,
            pastGameResults: [FlagGameResult](),
            numberOfAlternates: 5
        )
        
        print( "challenge \(challenge.answer.name)")
        print( "flag \(challenge.answer.flagEmoji)")
        print( "alternates.count \(challenge.alternates.count)")
    }
    
//    func test_MX_es() throws {
//        // TODO check if the MX flag is in the top 5
//    }
//
//    func test_CA_fr() throws {
//        // TODO check if the CA flag is in the top 5
//    }

    
    func testCountries() throws {

        print( "allCountries.count: \(IsoCountries.allCountries.count)")
        
        // allCountries.count: 249
        print( "english .count: \(IsoCountryCodes.searchByOfficialLanguage("en").count)")       // 194
        print( "french .count: \(IsoCountryCodes.searchByOfficialLanguage("fr").count)")        // 27
        print( "spanish .count: \(IsoCountryCodes.searchByOfficialLanguage("es").count)")       // 19
        
        print( "korean .count: \(IsoCountryCodes.searchByOfficialLanguage("ko").count)")        // 2
        print( "japanese .count: \(IsoCountryCodes.searchByOfficialLanguage("ja").count)")      // 1
        print( "italian .count: \(IsoCountryCodes.searchByOfficialLanguage("it").count)")       // 1
        print( "turkish .count: \(IsoCountryCodes.searchByOfficialLanguage("tr").count)")       // 1
        print( "polish .count: \(IsoCountryCodes.searchByOfficialLanguage("pl").count)")        // 1
        print( "portugese .count: \(IsoCountryCodes.searchByOfficialLanguage("pt").count)")     // 3
        print( "german .count: \(IsoCountryCodes.searchByOfficialLanguage("de").count)")        // 2
        print( "chinese .count: \(IsoCountryCodes.searchByOfficialLanguage("zh").count)")       // 5
        // Chinese (Simplified)
        // Chinese (Traditional)
        print( "arabic .count: \(IsoCountryCodes.searchByOfficialLanguage("ar").count)")        // ?
        print( "greek .count: \(IsoCountryCodes.searchByOfficialLanguage("el").count)")         // 1
        print( "russian .count: \(IsoCountryCodes.searchByOfficialLanguage("ru").count)")         // 1

        // TODO
        // dutch ? "official_language":"nl",            ~2
        
        //Ukrainian
        //Hebrew
        //Thai
        //Vietnamese
        //Swedish
        
        // Catalan
        // Croatian
        // Czech
        // Danish
        // Finnish
        // Hindi
        // Hungarian
        // Indonesian
        // Malay
        // Norwegian
        // Romanian
        // Slovak
        
//        let englishSpeaking = IsoCountryCodes.searchByOfficialLanguage("en")
//        let frenchSpeaking = IsoCountryCodes.searchByOfficialLanguage("fr")
//        let spanishSpeaking = IsoCountryCodes.searchByOfficialLanguage("es")
//        print( "frenchSpeaking \(frenchSpeaking)")
//        print( "spanishSpeaking \(spanishSpeaking)")
//        print( "englishSpeaking \(englishSpeaking)")
    }
    
    func testGenerateFakeData() throws {
        
        let bday = Calendar.current.date(byAdding: .year, value: -45, to: Date())!
        
        let playerNumberOfDaysOld: Double
        
        let date1 = Calendar.current.startOfDay(for: bday)
        let date2 = Calendar.current.startOfDay(for:Date())
        let components = Calendar.current.dateComponents([.day], from: date1, to: date2)
        if let days = components.day {
            playerNumberOfDaysOld = Double(days)
        } else {
            fatalError()
        }
        
        FlagGameMLTrainingEvent.dumpFakeDataCountryTrainingEveryCountryGetsItsOwnVote(playerNumberOfDaysOld: playerNumberOfDaysOld)
        FlagGameMLTrainingEvent.dumpFakeDataCountryTrainingEveryCountryVoteForLanguage(playerNumberOfDaysOld: playerNumberOfDaysOld)
    }
}
