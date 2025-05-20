//
//  TeamResponse.swift
//  Sports
//
//  Created by Macos on 20/05/2025.
//

import Foundation

struct LeagueTeamsResponse : Codable{
    var result: LeaguesTeamsResult
}

struct LeaguesTeamsResult : Codable{
    var total : [LeagueTeams]
}
