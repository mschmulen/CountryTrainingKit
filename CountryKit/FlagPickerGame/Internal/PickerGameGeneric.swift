//
//  PickerGameGeneric.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/12/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

struct PickerGameGeneric<CardContent> where CardContent: Equatable {
    
    var cards: Array<Card>
    var word: String
    
    private var target: CardContent
    
    init(
        target: CardContent,
        word: String,
        numberOfCards: Int,
        cardContentFactory: (Int)->CardContent
    ) {
        cards = Array<Card>()
        for cardIndex in 0..<numberOfCards {
            let content = cardContentFactory(cardIndex)
            if content == target {
                cards.append(Card(isCorrectCard: true, content: content, id: cardIndex))
            } else {
                cards.append(Card(isCorrectCard: false, content: content, id: cardIndex))
            }
        }
        
        self.target = target
        self.word = word
        cards.shuffle()
    }
    
    mutating func choose( card: Card ) -> Result<Bool, Error> {
        
        if let choosenIndex = cards.firstIndex(matching: card) {
            self.cards[choosenIndex].wasPicked = true
            if self.cards[choosenIndex].isCorrectCard {
                return .success(true)
            } else {
                return .success(false)
            }
        }
        return .failure(GameError.unknown)
    }
    
    struct Card : Identifiable {
        var wasPicked = false
        var isCorrectCard: Bool
        var content: CardContent
        var id: Int
    }
    
    enum GameError: Error {
        case unknown
    }
    
}

