//
//  PickerGameEmojiViewModel.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/12/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import SwiftUI

public class PickerGameEmojiViewModel: ObservableObject {
    
    @Published private var model: PickerGameGeneric<String>
    
    @Published private var numberOfAttempts: Int
    
    @Published private var gameSolved: Bool
    
    public init(
        targetEmoji: String,
        targetWord: String,
        alternates: [String]
    ) {
        var emojis = alternates
        emojis.append(targetEmoji)
        
        model = PickerGameGeneric<String>(
            target: targetEmoji,
            word: targetWord,
            numberOfCards: emojis.count
        ) { i in
            return emojis[i]
        }
        
        numberOfAttempts = 0
        gameSolved = false
    }
    
    enum ViewModelError: Error {
        case unknown
    }
}

extension PickerGameEmojiViewModel {
    
    // MARK: - Accessors
    var cards: Array<PickerGameGeneric<String>.Card> {
        model.cards
    }
    
    var word: String {
        return model.word
    }
    
    // MARK: - Intent(s)
    func choose(card: PickerGameGeneric<String>.Card) -> Result<Bool, Error> {
        
        if gameSolved == true {
            print("game already solved so dont allow more selection")
            return .failure(ViewModelError.unknown)
        }
        
        numberOfAttempts += 1
        
        let result =  model.choose(card: card)
        switch result {
        case .success(let result):
            gameSolved = result
        case .failure(let error):
            print("failure error \(error)")
        }
        return result
    }
    
    var isSolved: Bool {
        return gameSolved
    }
    
}

