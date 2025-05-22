//
//  Config.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import Foundation

struct Config {
    static let apiKey = "63695114a745abb177d7c3a1a38eac7859f5bf0e607c7b6673d250a7240d5277"
    
    static func teamImage(teamKey : Int, team : String , sport:String)->String{
        let teamName = team
                .lowercased()
                .trimmingCharacters(in: .whitespacesAndNewlines)
                .components(separatedBy: CharacterSet.alphanumerics.inverted)
                .filter { !$0.isEmpty }
                .joined(separator: "_")
        var image = ""
        switch sport {
        case "football":
            image = "https://apiv2.allsportsapi.com/logo/\(teamKey)_\(teamName).jpg"
        case "cricket":
            image = "https://apiv2.allsportsapi.com/logo-cricket/\(teamKey)_\(teamName).jpg"
        case "basketball":
            image = "https://apiv2.allsportsapi.com/logo-basketball/\(teamKey)_\(teamName).jpg"
        default:
            image = "https://apiv2.allsportsapi.com/logo/\(teamKey)_\(teamName).jpg"
        }
        return image
    }
}
