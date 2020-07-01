//
//  FlagGamePickerDataModel.swift
//  CountryKit
//
//  Created by Matthew Schmulen on 6/11/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

public struct FlagGamePickerDataModel: Identifiable, Codable {
    
    public typealias DataItem = FlagGamePickerDataModel
    
    public let id: UUID = UUID()
    
    public var title: String
    
    public var answer: SimplifiedFlagModel
    
    public var alternates: [SimplifiedFlagModel]
    
    public var predictedNumberOfGuesses: Double
    
    public struct SimplifiedFlagModel: Identifiable, Codable {
        
        public let id: UUID
        public var name: String
        public var flagEmoji: String
        
        public static var mock: SimplifiedFlagModel {
            return SimplifiedFlagModel(
                id: UUID(),
                name: "Canada",
                flagEmoji: "🇨🇦"
            )
        }
    }
}

extension FlagGamePickerDataModel {
    
    public static var mock: DataItem {
        return FlagGamePickerDataModel(
            title: "mock",
            answer: SimplifiedFlagModel.mock,
            alternates: [
                SimplifiedFlagModel.mock,
                SimplifiedFlagModel.mock,
                SimplifiedFlagModel.mock
            ],
            predictedNumberOfGuesses: 2.0
        )
    }
    
}
