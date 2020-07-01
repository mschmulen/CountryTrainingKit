//
//  GameResult.swift
//  mini13
//
//  Created by Matthew Schmulen on 6/9/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

/// GameResult
public struct FlagGameResult: Codable {
    
    public var flagEmoji: String
    public var name: String
    public var predictedNumberOfGuesses: Double
    public var acutalNumberOfGuesses: Double

    public init(
        flagEmoji: String,
        name: String,
        predictedNumberOfGuesses: Double,
        acutalNumberOfGuesses: Double
    ) {
        self.flagEmoji = flagEmoji
        self.name = name
        self.predictedNumberOfGuesses = predictedNumberOfGuesses
        self.acutalNumberOfGuesses = acutalNumberOfGuesses
    }
}

