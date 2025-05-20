//
//  Network.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import Foundation
import Alamofire

protocol NetworkProtocol{
    static func fetchDataFromJSON(sport : String? ,complitionHandler: @escaping (LeaguesResponse?) -> Void)
    static func getUpComingEvents(leagueId : Int?, sport : String? ,complitionHandler: @escaping (EventRespose?) -> Void)
    static func getUpLatestEvents(leagueId : Int?, sport : String? ,complitionHandler: @escaping (EventRespose?) -> Void)
    static func getTeamDetails(teamId: Int, sport : String? ,complitionHandler: @escaping (TeamResponse?) -> Void)
}


class Network:NetworkProtocol{


    
    static func fetchDataFromJSON(sport : String? , complitionHandler: @escaping (LeaguesResponse?) -> Void) {

        guard let sportType = sport else {
            return
        }
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Leagues&APIkey=\(Config.apiKey)"

        AF.request(url).responseDecodable(of: LeaguesResponse.self) { response in
             switch response.result {
             case .success(let data):
                 DispatchQueue.main.async {
                     complitionHandler(data)

                 }
             case .failure(let error):
                 print("\(error.localizedDescription)")
                 DispatchQueue.main.async {
                     complitionHandler(nil)
                 }
             }
         }

    }
    
    static func getUpComingEvents(leagueId: Int?, sport : String? ,complitionHandler: @escaping (EventRespose?) -> Void){
        guard let sportType = sport else {
            return
        }
        guard let league = leagueId else{
            return
        }
        let currentDate = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: currentDate)
        guard let nextWeeks = calendar.date(byAdding: .day, value: 10, to: currentDate) else { return
        }
        let nextWeeksFormattedDate = formatter.string(from: nextWeeks)
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&leagueId=\(league)&from=\(formattedDate)&to=\(nextWeeksFormattedDate)&APIkey=\(Config.apiKey)"

        AF.request(url).responseDecodable(of: EventRespose.self) { response in
             switch response.result {
             case .success(let data):
                 print("sucess")
                 DispatchQueue.main.async {
                     complitionHandler(data)

                 }
             case .failure(let error):
                 print("\(error.localizedDescription)")
                 DispatchQueue.main.async {
                     complitionHandler(nil)
                 }
             }
         }
    }
    static func getUpLatestEvents(leagueId : Int?, sport : String? ,complitionHandler: @escaping (EventRespose?) -> Void){
        guard let sportType = sport else {
            return
        }
        guard let league = leagueId else{
            return
        }
        let calendar = Calendar.current
        let currentDate = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        guard let yasterday = calendar.date(byAdding: .day, value: -1, to: currentDate) else { return
        }
        let yasterdayFormattedDate = formatter.string(from: yasterday)

        guard let weekAgo = calendar.date(byAdding: .day, value: -8, to: currentDate) else { return
        }
        let weekFormattedDate = formatter.string(from: weekAgo)
        
        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Fixtures&leagueId=\(league)&to=\(yasterdayFormattedDate)&from=\(weekFormattedDate)&APIkey=\(Config.apiKey)"

        AF.request(url).responseDecodable(of: EventRespose.self) { response in
             switch response.result {
             case .success(let data):
                 print("sucess")
                 DispatchQueue.main.async {
                     complitionHandler(data)

                 }
             case .failure(let error):
                 print("\(error.localizedDescription)")
                 DispatchQueue.main.async {
                     complitionHandler(nil)
                 }
             }
         }
    }
    static func getTeams(leagueId: Int, sport : String? ,complitionHandler: @escaping (LeagueTeamsResponse?) -> Void){
        guard let sportType = sport else {
            return
        }

        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Standings&leagueId=\(leagueId)&APIkey=\(Config.apiKey)"


        AF.request(url).responseDecodable(of: LeagueTeamsResponse.self) { 
            response in
            switch response.result {
             case .success(let data):
                 print("sucess")
                 DispatchQueue.main.async {
                     complitionHandler(data)

                 }
             case .failure(let error):
                 print("\(error.localizedDescription)")
                 DispatchQueue.main.async {
                     complitionHandler(nil)
                 }
             }
         }
    }

    static func getTeamDetails(teamId: Int, sport : String? ,complitionHandler: @escaping (TeamResponse?) -> Void){
        guard let sportType = sport else {
            return
        }

        let url = "https://apiv2.allsportsapi.com/\(sportType)/?met=Teams&teamId=\(teamId)&APIkey=\(Config.apiKey)"


        AF.request(url).responseDecodable(of: TeamResponse.self) { response in
             switch response.result {
             case .success(let data):
                 print("sucess")
                 DispatchQueue.main.async {
                     complitionHandler(data)

                 }
             case .failure(let error):
                 print("\(error.localizedDescription)")
                 DispatchQueue.main.async {
                     complitionHandler(nil)
                 }
             }
         }
    }

}
