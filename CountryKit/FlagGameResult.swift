//
//  GameResult.swift
//  mini13
//
//  Created by Matthew Schmulen on 6/9/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

/// FlagGameResult , result of a flag game session
public struct FlagGameResult: Codable {
    
    /// flagEmoji content
    public var flagEmoji: String
    
    /// countryName
    public var countryName: String
    
    /// predictedNumberOfGuesses
    public var predictedNumberOfGuesses: Double
    
    /// predictedNumberOfGuesses
    public var acutalNumberOfGuesses: Double

    public init(
        flagEmoji: String,
        name: String,
        predictedNumberOfGuesses: Double,
        acutalNumberOfGuesses: Double
    ) {
        self.flagEmoji = flagEmoji
        self.countryName = name
        self.predictedNumberOfGuesses = predictedNumberOfGuesses
        self.acutalNumberOfGuesses = acutalNumberOfGuesses
    }
}



