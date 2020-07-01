//
//  PickerGameCardView.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/12/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import SwiftUI

struct PickerGameCardView: View {
    
    var card: PickerGameGeneric<String>.Card
    
    var body: some View {
        GeometryReader { geometry in
            self.body(for: geometry.size)
        }//end GeometryReader
    }//end body

    func body(for size: CGSize ) -> some View {
        var width = size.width
        var height = size.height
        if width < height {
            height = width
        } else {
            width = height
        }
        
        let v = ZStack {
            if self.card.wasPicked {
                if self.card.isCorrectCard {
                    RoundedRectangle(cornerRadius:cornerRadius).fill(Color.green)
                    RoundedRectangle(cornerRadius:cornerRadius).stroke(lineWidth:edgeLineWidth)
                    Text(self.card.content)
                }
                else {
                    RoundedRectangle(cornerRadius:cornerRadius).fill(Color.red)
                    RoundedRectangle(cornerRadius:cornerRadius).stroke(lineWidth:edgeLineWidth)
                    Text(self.card.content)
                }
            } else {
                RoundedRectangle(cornerRadius:cornerRadius).fill(Color.white)
                RoundedRectangle(cornerRadius:cornerRadius).stroke(lineWidth:edgeLineWidth)
                Text(self.card.content)
            }
        }
        .font(
            Font.system(size: fontSize(for: size) )
        )
        .frame(width:width, height:height)
        
        return v
    }
    
    // MARK: - Drawing Constants
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let fontMultiplier: CGFloat = 0.75
    
    func fontSize(for size: CGSize ) -> CGFloat {
        min(size.width, size.height) * fontMultiplier
    }
}
