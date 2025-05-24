//
//  Leauges.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import Foundation

struct Leagues:Codable{
    let league_key:Int
    let league_name: String
    let league_logo :String?
}







/*

 note

 we can use this to make json keys equal with url
 enum CodingKeys: String, CodingKey {
     case leagueKey = "league_key"
     case leagueName = "league_name"
     case leagueLogo = "league_logo"
 }
 */
