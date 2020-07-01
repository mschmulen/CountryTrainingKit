//
//  PickerGameView.swift
//  CountryTrainingKit
//
//  Created by Matthew Schmulen on 6/12/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import SwiftUI
import AVFoundation

public typealias GameOverCallback = (Result<Double, Error>)->Void
public typealias GameViewCloseCallback = (Result<Double, Error>)->Void

protocol GameView {
    var gameOverCallback: GameOverCallback  { get }
    func close(numberOfGuesses:Double)
}

public struct PickerGameView: View, GameView {
    
    @Environment(\.presentationMode) var presentationMode
    
    @ObservedObject var viewModel: PickerGameEmojiViewModel
    
//    let localeCurrentLanguageCode: String
//    let localeCurrentRegionCode: String
    let gameOverCallback: GameOverCallback
    let agentViewModel: CountryTeacherAgentViewModel
    
    // animation state stuff
    @State private var wordFontSize: CGFloat = 50.0
    @State private var wordForegroundColor: Color = Color.yellow
    @State private var wordOpacity: Double = 1
    
    // proficiency state, scoring
    @State private var numberOfGuesses: Int = 0
    @State private var numberOfHints: Int = 0
    
    public init (
        viewModel: PickerGameEmojiViewModel,
        agentViewModel: CountryTeacherAgentViewModel,
        gameOverCallback: @escaping GameViewCloseCallback
    ) {
        self.viewModel = viewModel
        self.agentViewModel = agentViewModel
        self.gameOverCallback = gameOverCallback
    }
    
    public var body: some View {
        ZStack{
            gameView
            VStack(alignment: .leading){
                HStack{
                    Spacer()
                }
                Spacer()
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                self.playInto()
            }
        }
    }
    
    var wordTextView: some View {
        
        Text("\(viewModel.word)")
            .onTapGesture {
                self.playHelpMe()
        }
    }
    
    var gameView: some View {
        VStack {
            wordTextView
            GridView( viewModel.cards) { card in
                PickerGameCardView(card: card).onTapGesture{
                    switch self.viewModel.choose(card:card) {
                    case .failure(let error):
                        print("there was some internal error \(error)")
                    case .success(let result):
                        if result == false {
                            self.wrongAnswer(card:card)
                        } else {
                            self.correctAnswer()
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                self.close(numberOfGuesses: Double(self.numberOfGuesses))
                            }
                        }
                    }
                }
                .frame(width:100, height: 100)
                //.padding(8)
            }
            Text(viewModel.word)
//            .padding()
//            .foregroundColor(Color.orange)
        }
        .padding()
        .foregroundColor( viewModel.isSolved ? Color.green : Color.orange )
    }
    
    func close( numberOfGuesses: Double)  {
        self.gameOverCallback(.success(numberOfGuesses))
        self.presentationMode.wrappedValue.dismiss()
    }
}

// Mark: - Feedback actions
extension PickerGameView {
    
//    mutating func loadAudio(){
//        let path = Bundle.main.path(forResource: "example.mp3", ofType:nil)!
//        let url = URL(fileURLWithPath: path)
//
//        do {
//            promptSoundEffect = try AVAudioPlayer(contentsOf: url)
//            promptSoundEffect?.play()
//        } catch {
//            // couldn't load file :(
//        }
//
//        // dont forget to promptSoundEffect?.stop()
//    }
    
    func playInto() {
        agentViewModel.expressInstructions()
    }
    
    func playHelpMe() {
        numberOfHints += 1
        agentViewModel.expressHelp(topic: viewModel.word)
    }
    
    func correctAnswer() {
        numberOfGuesses += 1
        agentViewModel.expressSuccess()
    }
    
    func wrongAnswer(card: PickerGameGeneric<String>.Card) {
        numberOfGuesses += 1
        agentViewModel.expressFailure()
        
        if let cardWord = getWordForCard(card:card) {
            sayWord(word: cardWord)
        }
    }
    
    func getWordForCard( card: PickerGameGeneric<String>.Card) -> String? {
        return card.content
    }
    
    func sayWord(word: String) {
        agentViewModel.sayWord(word)
    }
    
}

