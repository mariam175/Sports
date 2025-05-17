//
//  TeamDetails.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import Foundation

struct TeamDetails:Codable{
    let team_name: String
    let team_logo: String?
    let coaches: [Coach]?
    let players: [Player]?
}
