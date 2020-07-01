//
//  Array+Identifiable.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/15/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

extension Array where Element: Identifiable {
    func firstIndex( matching: Element) -> Int? {
        for index in 0..<self.count {
            if self[index].id == matching.id {
                return index
            }
        }
        return nil
    }
    
}

extension Array {
    var only: Element? {
        count == 1 ? first: nil
    }
}

