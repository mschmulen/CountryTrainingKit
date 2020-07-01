//
//  PlayerConfigView.swift
//  DemoApp
//
//  Created by Matthew Schmulen on 6/23/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import SwiftUI
import CountryTrainingKit

struct PlayerConfigView: View {
    
    @EnvironmentObject var appState: AppState
    
    @State private var birthDate = Date()
    @State private var localRegion: RegionOptions = .US
    @State private var localLanguage: LanguageOptions = .en
    @State private var extraLanguage: LanguageOptions = .es
    @State private var enableExtraLanguage: Bool = false
    @State private var localName: String = "Susy"
    @State private var enableVoiceOver:  Bool = false
    @State private var enableML: Bool = true
    
    enum LanguageOptions: String, CaseIterable {
        case en
        case es
        case fr
        case ar
    }
    
    enum RegionOptions: String, CaseIterable {
        case US
        case FR
        case MX
        case CA
    }
    
    var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .long
        return formatter
    }
    
    var starterDate: Date {
        return Calendar.current.date(byAdding: .year, value: -30, to: Date()) ?? Date()
    }
    
    var playerNumberOfDaysOld: Double? {
        let date = birthDate
        let calendar = Calendar.current
        let date1 = calendar.startOfDay(for: date)
        let date2 = calendar.startOfDay(for:Date())
        let components = calendar.dateComponents([.day], from: date1, to: date2)
        if let days = components.day {
            return Double(days)
        } else {
            return nil
        }
    }
    
    var agentConfig: some View {
        VStack {
            Toggle(isOn: $enableVoiceOver) {
                Text("Agent enableVoiceOver")
                    .font(.caption)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
            Toggle(isOn: $enableML) {
                Text("enableML")
                    .font(.caption)
            }
            .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            
        }
    }
    
    var playerConfig: some View {
        VStack {
            TextField("Enter your name", text: $localName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
            VStack{
                Text("Select your birthday")
                    .font(.caption)
                DatePicker(selection: $birthDate, in: ...starterDate, displayedComponents: .date) {
                    Text("Select your birthday")
                }
                .labelsHidden()
            }
            .padding()
            .border(Color.gray)
            
            VStack{
                Text("Langage: \(localLanguage.rawValue)")
                    .font(.caption)
                Picker(selection: $localLanguage, label: Text("Langage")) {
                    ForEach(LanguageOptions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
            }
            
            VStack{
                Text("Region: \(localRegion.rawValue)")
                    .font(.caption)
                Picker("Region",selection: $localRegion) {
                    ForEach(RegionOptions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            
            VStack{
                Toggle(isOn: $enableExtraLanguage) {
                    Text("enableExtraLanguage")
                        .font(.caption)
                }
                .padding(EdgeInsets(top: 0, leading: 10, bottom: 0, trailing: 10))
                Text("Extra Langage: \(extraLanguage.rawValue)")
                    .font(.caption)
                Picker(selection: $extraLanguage, label: Text("Langage")) {
                    ForEach(LanguageOptions.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
                .labelsHidden()
                .pickerStyle(SegmentedPickerStyle())
                .padding(EdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0))
            }
        }
    }//end playerConfig
    
    var actionView: some View {
        Button(action: {
            self.appState.topView = .flagTrainingView
            
            self.appState.agentData = AgentData(
                agentType: self.enableML ? .ml : .random,
                enableVoiceOver: self.enableVoiceOver
            )
            self.appState.playerData = AppPlayerData(
                playerName: self.localName,
                localeCurrentLanguageCode: self.localLanguage.rawValue,
                localeCurrentRegionCode: self.localRegion.rawValue,
                alternateLanguage: "none",
                playerNumberOfDaysOld: self.playerNumberOfDaysOld ?? Double(9400),
                devicePreferredLanguages: self.enableExtraLanguage ? [String]() : [self.extraLanguage.rawValue],
                deviceIdentifierForVendor: UUID().uuidString
            )
            self.appState.topView = .flagTrainingView
        }) {
            Text("Play \(self.localName): \(self.localRegion.rawValue) \(self.localLanguage.rawValue)")
        }
    }//end actionView
    
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            Text("PlayerOnboardingView")
            actionView
            
            self.agentConfig
            
            self.playerConfig
        }
    }//end body
    
}

