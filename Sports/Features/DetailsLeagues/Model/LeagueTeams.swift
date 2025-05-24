//
//  LeagueTeams.swift
//  Sports
//
//  Created by Macos on 20/05/2025.
//

import Foundation

struct LeagueTeams : Codable{
    var standing_team : String
    var team_key : Int
}

extension LeagueTeams{
    func match()->Standing{
        return Standing(teamKey: self.team_key, teamName: self.standing_team)
    }
}
