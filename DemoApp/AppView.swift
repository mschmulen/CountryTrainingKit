//
//  AppView.swift
//  DemoApp
//
//  Created by Matthew Schmulen on 6/23/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import SwiftUI
import CountryTrainingKit

struct AppView: View {
    
    @EnvironmentObject var appState: AppState
    
//    var body: some View {
//        return Text("")
//    }
    
    var body: some View {
            // NavigationView {
            Group {
                
                // Show the Buttons if topView is none
                if appState.topView == .none {
                    Spacer()
                    VStack {
                        VStack {
                            Button(action: {
                                self.appState.topView = .flagTrainingView
                            }) {
                                Text("flagTrainingView")
                            }
                        }
                    }//end VStack
                }//end if appState.topView == .none
                
                // Top Level view override
                if appState.agentData != nil && appState.playerData != nil {
                    Group {
                        // Flag flagTrainingView
                        if appState.topView == .flagTrainingView {
                            ContentView(
                                countryPlayerData: appState.playerData!,
                                agent: appState.agentData!
                            )
                        }
                        EmptyView()
                    }
                }
                
                if appState.topView == .playerOnboardingView {
                    PlayerConfigView()
                }
                
                // None this is Dev debug state
                if appState.topView == .none {
                    VStack{
                        
                        Button(action: {
                            self.appState.topView = .playerOnboardingView
                        }) {
                            Text("appOnboardingView")
                        }
                        Spacer()
                    }
                }
                EmptyView()
            }
        }
    
}
