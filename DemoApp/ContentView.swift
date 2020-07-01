//
//  ContentView.swift
//  DemoApp
//
//  Created by Matthew Schmulen on 6/16/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import SwiftUI
import CountryTrainingKit

struct ContentView: View {
    
    @EnvironmentObject var appState: AppState
    
    private let countryPlayerData: AppPlayerData
    private let agent: AgentData
    private let agentViewModel: CountryTeacherAgentViewModel
    
    // showing state
    @State private var showingCurrentChallengeView = false
    @State private var showingAllFlagsComplete = false
    
    // current challenge info
    @State private var currentChallengeModel = FlagGamePickerDataModel.mock
    @State private var predictedNumberOfGuesses: Double = 0
    
    // session info
    @State private var sessionResults = [CountryTrainingKit.FlagGameResult]()
    @State private var thisSessionAverageNumberOfGuesses: Double = 0
    
    init(
        countryPlayerData: AppPlayerData,
        agent: AgentData
    ) {
        self.countryPlayerData = countryPlayerData
        self.agent = agent
        
        let vm = CountryTeacherAgentViewModel(
            agent: agent,
            localeCurrentLanguageCode: countryPlayerData.localeCurrentLanguageCode,
            localeCurrentRegionCode: countryPlayerData.localeCurrentRegionCode,
            alternateLanguage: countryPlayerData.alternateLanguage,
            deviceIdentifierForVendor: countryPlayerData.deviceIdentifierForVendor,
            playerNumberOfDaysOld: countryPlayerData.playerNumberOfDaysOld
        )
        self.agentViewModel = vm
    }
    
    var body: some View {
        VStack {
            headerView()
            
            // challenge button
            Button(action: {
                self.showingCurrentChallengeView = true
            }) {
                ZStack {
                    Text("🌏")
                        .font(Font.system(size: self.defaultEmojiSize))
                        .padding()
                    Text("\(predictedNumberOfGuesses)")
                        .foregroundColor(Color.black)
                }
            }
            .sheet(isPresented: self.$showingCurrentChallengeView, content:{
                self.playingSheet(
                    dataModel: self.currentChallengeModel
                )
                    .background(self.sheetBackgroundColor)
            })//end Sheet
            
            infoView
            
        }.onAppear {
            
            self.thisSessionAverageNumberOfGuesses = 0.0
            
            self.fetchNextChallenge()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                self.playTraininigIntro()
            }
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showingCurrentChallengeView = true
            }
        }
        .background(backgroundColor)
    }//end body
    
    
    func headerView(name:String = "Flag Trainer") -> some View {
        HStack {
            Text(name)
            Spacer()
            Button(action: {
                //self.appState.topView = .none
                self.appState.topView = .playerOnboardingView
            }) {
                Image(systemName: "x.circle.fill")
                    .imageScale(.large)
                    .accessibility(label: Text("close"))
            }
        }
        .padding()
        .background(Color.gray)
    }//end headerView
    
    func sharedCloseCallback(_ result: Result<Double, Error>) {
        self.showingCurrentChallengeView = false
        
        switch result {
        case .failure(let error):
            print( "failure error \(error)")
            self.fetchNextChallenge()
        case .success(let proficiency):
            let result = FlagGameResult(
                flagEmoji: self.currentChallengeModel.answer.flagEmoji,
                name: self.currentChallengeModel.answer.name,
                predictedNumberOfGuesses: predictedNumberOfGuesses,
                acutalNumberOfGuesses: proficiency
            )
            sessionResults.append( result )
            dispatchMachineLearningEventToServer(gameResult: result)
            
            //update the sessionPlayerRank
            if sessionResults.count > 0 {
                var totalGuesses:Double = 0
                for session in sessionResults {
                    totalGuesses += session.predictedNumberOfGuesses
                }
                thisSessionAverageNumberOfGuesses = totalGuesses/Double(sessionResults.count)
            } else {
                thisSessionAverageNumberOfGuesses = 0.0
            }
            
            self.fetchNextChallenge()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.showingCurrentChallengeView = true
            }
            
        }//end switch
    }//end sharedCloseCallback
    
    func playingSheet( dataModel: FlagGamePickerDataModel) -> some View {
        
        let alternateEmojis = dataModel.alternates.map { (model) -> String in
            model.flagEmoji
        }
        
        let targetWord = dataModel.answer.name
        
        let gameViewModel = PickerGameEmojiViewModel(
            targetEmoji: dataModel.answer.flagEmoji,
            targetWord: targetWord,
            alternates: alternateEmojis
        )
        
        let gameView = PickerGameView(
            viewModel: gameViewModel,
            agentViewModel: self.agentViewModel,
            gameOverCallback: { result in
                self.sharedCloseCallback(result)
        })
        return gameView
    }//end playingSheet
    
    var infoView: some View {
        VStack(alignment: .leading, spacing: 5.0) {
            
            Text("predictedNumberOfGuesses \(predictedNumberOfGuesses)")
            Text("thisSessionAverageNumberOfGuesses \(thisSessionAverageNumberOfGuesses)")
            
            Group { // Session Results
                Text("sessionResults.count \(sessionResults.count)")
            }
            
            // Player stuff
            Group {
                Text("language \(countryPlayerData.localeCurrentLanguageCode)")
                Text("region \(countryPlayerData.localeCurrentRegionCode)")
                Text("age \(countryPlayerData.playerNumberOfDaysOld)")
                Text("devicePreferredLanguages \(countryPlayerData.devicePreferredLanguages.description)")
                Text("playerName \(countryPlayerData.playerName)")
            }
            
            // agent stuff
            Group {
                Text("agent.agentType: \(agent.agentType.info)")
                Text("agent.enableVoiceOver: \(agent.enableVoiceOver ? "TRUE" : "FALSE")")
            }
            
            actionsView
            
        }//end VStack
            .sheet(isPresented: self.$showingAllFlagsComplete, content:{
                Text("All Flags Complete !")
            })
    }//end infoView
    
    
    var actionsView: some View {
        Group { // Misc actions
            Button(action: {
                self.sessionResults = [FlagGameResult]()
            }) {
                Text("reset session")
            }
            
            Button(action: {
                self.agentViewModel.dumpData()
            }) {
                Text("dumpData")
            }
        }
    }// actionsView
    
    
    
    func playTraininigIntro() {
        switch Int.random(in: 0..<8) {
        case 0:
            self.agentViewModel.expressGreeting(playerName: countryPlayerData.playerName)
        case 1:
            self.agentViewModel.expressIntroduction(playerName: countryPlayerData.playerName)
        case 2:
            self.agentViewModel.expressLetsGetStarted()
        default:
            break // do nothing
        }
    }
    
    func fetchNextChallenge() {
        do {
            let flagModel = try agentViewModel.generateChallenge(
                deviceAlternateLanguage: "none",
                pastGameResults: sessionResults,
                numberOfAlternates: 11 //default is 5
            )
            predictedNumberOfGuesses = flagModel.predictedNumberOfGuesses
            currentChallengeModel = flagModel
        } catch( let error ) {
            print( "\(error)")
            // reset the sessionResults
            sessionResults = [FlagGameResult]()
            // Game over show the number of sessions
            showingAllFlagsComplete.toggle()
            return
        }
    }
    
    // MARK: - Drawing Constants
    let backgroundColor: Color = Color.green
    let sheetBackgroundColor: Color = Color.blue
    let frameHeight: CGFloat = 100.0
    let cornerRadius: CGFloat = 10.0
    let edgeLineWidth: CGFloat = 3.0
    let defaultEmojiSize: CGFloat = 70.0
}

extension ContentView {
    
    // TODO have the playerAgent manage this
    func dispatchMachineLearningEventToServer( gameResult: CountryTrainingKit.FlagGameResult ) {
        self.agentViewModel.dispatchMachineLearningEventToServer(gameResult: gameResult)
    }// dispatchMachineLearningEventToServer
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(
            countryPlayerData: AppPlayerData.mockRandom,
            agent: AgentData.mockML
        )
    }
}
