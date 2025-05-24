//
//  TeamResponse.swift
//  Sports
//
//  Created by Macos on 20/05/2025.
//

import Foundation

struct LeagueTeamsResponse<T:Codable> : Codable{
    var success : Int
    var result: T
}

struct LeaguesTeamsResult : Codable{
    var total : [LeagueTeams]
}
