//
//  Event.swift
//  Sports
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct Event : Codable{
    var event_date : String
    var event_time : String
    var event_home_team : String
    var event_away_team : String
    var event_ft_result : String
    var league_name : String
    var home_team_logo : String
    var away_team_logo : String
    var home_team_key: Int
    var away_team_key : Int
}
