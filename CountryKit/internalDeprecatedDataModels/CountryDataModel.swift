//
//  CountryDataModel.swift
//  mini13
//
//  Created by Matthew Schmulen on 6/2/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

struct CountryDataModel: Identifiable, Codable {
    
    public typealias DataItem = CountryDataModel
    
    public let id: UUID =  UUID()
    public var title: String
    public var description: String
    public var population: Int
    
    // TODO rename gdpTotal:
    /// gdp PPP
    public var gdp: Int
    // TODO add gdpPerCapita:
    
    public var locationDMS: String
    public var locationDecimal: LocationDecimal
    
    public var wikipedia_link: String
    public var word_en: String
    public var word_fr: String
    public var word_es: String
    public var word_it: String
    
    public var notes_en: String
    public var notes_fr: String
    public var notes_es: String
    public var notes_it: String
    
    public var official_language: String
    public var languages: [String]
    public var flagEmoji: String
    
    /// alpha2 Country Code 
    public var countryCode: String
    
    /// continent
    public var continent:String // "EU"
    
    /// LocationDecimal
    public struct LocationDecimal: Codable {
        var latitude: Double
        var longitude: Double
    }
    
    public static func make(name:String, flagEmoji:String) -> CountryDataModel {
        return CountryDataModel(
            title: name,
            description: name,
            population: 35819000,
            gdp: 1000,
            locationDMS: "17°15′N 88°46′W",
            locationDecimal: CountryDataModel.LocationDecimal(latitude: 17.25, longitude: -88.766667),
            wikipedia_link: "https://en.wikipedia.org/wiki/Canada",
            word_en: name,
            word_fr: name,
            word_es: name,
            word_it: name,
            
            notes_en: "yack",
            notes_fr: "yack",
            notes_es: "yack",
            notes_it: "yack",
            
            official_language: "en",
            languages:["en","fr"],
            flagEmoji: flagEmoji,
            countryCode: "CA",
            continent: "EU"
        )
    }
    
    public static var mock: CountryDataModel {
        let new = CountryDataModel(
            title: "🇨🇦",
            description: "Canada 🇨🇦",
            population: 35819000,
            gdp: 1000,
            locationDMS: "17°15′N 88°46′W",
            locationDecimal: LocationDecimal(latitude: 17.25, longitude: -88.766667),
            wikipedia_link: "https://en.wikipedia.org/wiki/Canada",
            word_en: "Canada",
            word_fr: "Canada",
            word_es: "Canada",
            word_it: "Canada",
            
            notes_en: "yack",
            notes_fr: "yack",
            notes_es: "yack",
            notes_it: "yack",
            
            official_language: "en",
            languages:["en","fr"],
            flagEmoji: "🇨🇦",
            countryCode: "CA",
            continent: "EU"
        )
        return new
    }
    
    public static func fetchLocal() -> [CountryDataModel]{
        var models: [CountryDataModel] = [CountryDataModel]()
        for file in CountryDataModel.jsonFiles {
            models.append(contentsOf: CountryDataModel.load(file))
        }//end for
        return models
    } //end prime the server
    
    private static var jsonFiles: [String] {
        return [
            "countryDataModels_country_americas.json",
            //            "countryDataModels_country_apac.json",
            //            "countryDataModels_country_europe.json",
            //            "countryDataModels_country_africa.json",
            //            "countryDataModels_country_midEast.json"
        ]
    }
    
    private static func load(_ filename: String) -> [CountryDataModel] {
        let data: Data
        //guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
        guard let file = Bundle(for: CountryBank.self).url(forResource: filename, withExtension: nil)
            else {
                
                fatalError("Couldn't find \(filename) in main bundle.")
        }
        
        do {
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        
        do {
            let decoder = JSONDecoder()
            return try decoder.decode([CountryDataModel].self, from: data)
        } catch {
            fatalError("Couldn't parse \(filename) as \([CountryDataModel].self):\n\(error)")
        }
    }//end load
    
}//end struct
