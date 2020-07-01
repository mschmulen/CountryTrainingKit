//
//  AgentData.swift
//  mini13
//
//  Created by Matthew Schmulen on 5/31/20.
//  Copyright © 2020 jumptack. All rights reserved.
//

import Foundation

/// AgentData for configuring the AgentViewModel
public struct AgentData: Identifiable {
    
    public let id: UUID =  UUID()
    
    public var info: String {
        return "\(agentType.info) \(id) \(enableVoiceOver ? "voice enabled": "voice disabled") "
    }
    
    public enum AgentType {
        
        case random
        case ml
        
        public var info: String {
            switch self {
            case .random: return "random"
            case .ml: return "ml"
            }
        }
    }
    
    public let agentType: AgentType
    
    public let enableVoiceOver: Bool
    
    public init(
        agentType: AgentType,
        enableVoiceOver: Bool
    ) {
        self.agentType = agentType
        self.enableVoiceOver = enableVoiceOver
    }
}

extension AgentData {
    
    public static var mockRandom: AgentData {
        return AgentData(
            agentType: .random,
            enableVoiceOver: false
        )
    }
    
    public static var mockML: AgentData {
        return AgentData(
            agentType: .ml,
            enableVoiceOver: false
        )
    }
}

// MARK: - Speaking Agent phrases
extension AgentData {
    
    public func greetingString( language: String, playerName: String ) -> String {
        switch language {
        case "en":
            return ["Hello","Hello \(playerName)"].randomElement()!
        case "fr":
            return ["Bonjour","hello","Bonjour \(playerName)"].randomElement()!
        case "es":
            return "Hola \(playerName)"
        case "it":
            return "Ciao \(playerName)"
        default: return "no"

        }
    }
    
    public func letsHaveSomeFunString( language: String, playerName: String = "Susy" ) -> String {
        switch language {
        case "en":
            return "lets have some fun"
        case "fr":
            return "permet de s'amuser"
        case "es":
            return "vamos a divertirnos un poco"
        case "it":
            return "divertiamoci un po"
        default:
            return "no"
        }
    }
    
    public func IntroductionString(language: String, playerName: String ) -> String {
        switch language {
        case "en":
            return [
                "hello"
                ].randomElement()!
        case "fr":
            return [
                "Bonjour",
                "hello"
                ].randomElement()!
        case "es":
            return [
                "Hola"
                ].randomElement()!
        case "it":
            return [
                "Ciao"
                ].randomElement()!
        default: return "no"
        }
    }
    
    public func touchTheFlagForThisCountry(language: String ) -> String {
        switch language {
        case "en":
            return "touch the picture for this word"
        case "fr":
            return "toucher l'image pour ce mot"
        case "es":
            return "toca la imagen de esta palabra"
        case "it":
            return "tocca l'immagine per questa parola"
        default: return "no"
            
        }
    }
    
    public func pickTheFlagForThisCountry(language: String ) -> String {
        switch language {
        case "en":
            return "pick the flag for this country"
        case "fr":
            return "choisissez le drapeau de ce pays"
        case "es":
            return "elige la bandera de este país"
        case "it":
            return "scegli la bandiera per questo paese"
        default: return "no"
        }
    }
    
    public func introPhrasePickThe(language: String,  word:String ) -> String {
        switch language {
        case "en": return "pick the \(word)"
        case "fr": return "choisissez la \(word)"
        case "es": return "recoger la \(word)"
        case "it": return "prendi il \(word)"
        default: return "no"
        }
    }
    
    public func successString(language: String ) -> String {
        switch language {
        case "en":
            return ["Fantastic","Great","Excellent","Super"].randomElement()!
        case "fr":
            return ["fantastique","excellent","Très Bon","Bon travail","bon boulot"].randomElement()!
        case "es":
            return ["fantástico"].randomElement()!
        case "it":
            return ["fantastico"].randomElement()!
        default: return "no"
        }
    }
    
    public func failureString(language: String) -> String {
        switch language {
        case "en": return ["try again"].randomElement()!
        case "fr": return ["réessayer","no"].randomElement()!
        case "es": return ["Inténtalo de nuevo"].randomElement()!
        case "it": return ["riprova"].randomElement()!
        default: return "no"
        }
    }
}

