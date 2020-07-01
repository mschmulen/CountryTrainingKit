//
//  CountryBank.swift
//  mini13
//
//  Created by Matthew Schmulen on 6/2/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

class CountryBank {
    
    private let countries: [CountryDataModel]
    
    public let sumGDP:Int
    public let meanGDP:Int          // 939,341,063,801
    public let varianceGDP:Double
    public let stdDevGDP:Double
    
    // 100,000,000,000
    public let cutoffGDP:Int = 100000000000 // top 20 is basically swiz at 678,965,423,322 = 678 billion
    
    public let meanPopulation:Int
    
    public init() {
        //load the
        let allCountries = CountryDataModel.fetchLocal()
        self.countries = allCountries
        
        // GDP Calcualtions
        let sumGDP = allCountries.reduce(0, { inValue, model in
            return inValue + model.gdp
        })
        self.sumGDP = sumGDP
        let meanGDP = Double(sumGDP) / Double(allCountries.count)
        self.meanGDP = Int(meanGDP)
        let variance = allCountries.reduce(0, { inValue, model in
            return inValue + (Double(model.gdp) - meanGDP) * (Double(model.gdp) - meanGDP)
        })
        let stdDeviation = sqrt(Double(variance))
        self.varianceGDP = variance
        self.stdDevGDP = stdDeviation
        
        // let outlier1Deviations  = Int(meanGDP) + ( 1 * Int(stdDeviation))
        // let outlier2Deviations  = Int(meanGDP) + ( 2 * Int(stdDeviation))
        // let outlier3Deviations  = Int(meanGDP) + ( 3 * Int(stdDeviation))
        
        // Population Calcualtions
        let sumPopulation = allCountries.reduce(0, { a, b in
            return a + b.population
        })
        meanPopulation = Int(Double(sumPopulation) / Double(allCountries.count))
    }
    
    func calculateStats() {
        
        // let variance = mean + (differences of each from the mean)^2
        
        // let standardDeviation = SQRT(variance)
    }
}

extension CountryBank {
    
    public var all: [CountryDataModel] {
        return countries
    }
    
    public var sortedByRank: [CountryDataModel] {
        return countries.sorted {
            return $0.gdp >= $1.gdp
            
            // todo if the GDP is approximately the same ... within
            //            if $0.gdp != $1.gdp { // first, compare by gdp
            //                return $0.gdp < $1.gdp
            //            }
            //            else if $0.population != $1.population {
            //                return $0.population < $1.population
            //            }
            //
            //            // ... repeat for all other fields in the sorting
            //            else { // All other fields are tied, break ties random
            //                return true
            //            }
        }
    }
    
    public func filterByLanguage(language: String = "en") -> [CountryDataModel] {
        return countries.filter { country in
            country.official_language == language
        }
    }
    
    public var sortedByGDP: [CountryDataModel] {
        return countries.sorted { (country1, country2) -> Bool in
            country1.gdp >= country2.gdp
        }
    }
    
    public var sortedByPopulation: [CountryDataModel] {
        return countries.sorted { (country1, country2) -> Bool in
            country1.population >= country2.population
        }
    }
    
}





