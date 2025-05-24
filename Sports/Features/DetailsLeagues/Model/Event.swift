//
//  Event.swift
//  Sports
//
//  Created by Macos on 16/05/2025.
//

import Foundation

struct Event: Decodable {
    var event_date: String
    var event_time: String
    var event_home_team: String
    var event_away_team: String
    var event_final_result: String
    var league_name: String
    var home_team_logo: String?
    var away_team_logo: String?
    var home_team_key: Int
    var away_team_key: Int

    enum CodingKeys: String, CodingKey {
            case event_date
            case event_time
            case event_home_team
            case event_away_team
            case event_first_player
            case event_second_player
            case event_final_result
            case league_name
            case home_team_logo
            case away_team_logo
            case event_home_team_logo
            case event_away_team_logo
            case event_first_player_logo
            case event_second_player_logo
            case home_team_key
            case away_team_key
            case first_player_key
            case second_player_key
        }

        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)

            event_date = try container.decode(String.self, forKey: .event_date)
            event_time = try container.decode(String.self, forKey: .event_time)

            event_home_team =
                (try? container.decode(String.self, forKey: .event_home_team)) ??
                (try? container.decode(String.self, forKey: .event_first_player)) ?? "Unknown"

            event_away_team =
                (try? container.decode(String.self, forKey: .event_away_team)) ??
                (try? container.decode(String.self, forKey: .event_second_player)) ?? "Unknown"

            event_final_result = try container.decode(String.self, forKey: .event_final_result)
            league_name = try container.decode(String.self, forKey: .league_name)

            home_team_logo =
                (try? container.decode(String.self, forKey: .home_team_logo)) ??
                (try? container.decode(String.self, forKey: .event_home_team_logo)) ??
                (try? container.decode(String.self, forKey: .event_first_player_logo))

            away_team_logo =
                (try? container.decode(String.self, forKey: .away_team_logo)) ??
                (try? container.decode(String.self, forKey: .event_away_team_logo)) ??
                (try? container.decode(String.self, forKey: .event_second_player_logo))

            home_team_key =
                (try? container.decode(Int.self, forKey: .home_team_key)) ??
                (try? container.decode(Int.self, forKey: .first_player_key)) ?? 0

            away_team_key =
                (try? container.decode(Int.self, forKey: .away_team_key)) ??
                (try? container.decode(Int.self, forKey: .second_player_key)) ?? 0
        }
    }
