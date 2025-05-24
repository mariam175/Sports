//
//  TennisPlayers.swift
//  Sports
//
//  Created by Macos on 24/05/2025.
//

import Foundation

struct TennisPlayers:Codable{
    var place: String
        var player: String
        var player_key: Int?
        
}

extension TennisPlayers{
    func match()->Standing{
        return Standing(teamKey: self.player_key ?? 879, teamName: self.player)
    }
}
