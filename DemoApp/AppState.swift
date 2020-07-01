//
//  AppState.swift
//  DemoApp
//
//  Created by Matthew Schmulen on 6/23/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation
import CountryTrainingKit

class AppState:ObservableObject {
    
    enum TopView: CaseIterable {
        
        case flagTrainingView
        case playerOnboardingView
        
        case none
    }
    
    @Published var topView: TopView = .none
    @Published var playerData: AppPlayerData?
    @Published var agentData: AgentData?
    
//    var countryAgentData: CountryTrainingKit.AgentData?
    
}
