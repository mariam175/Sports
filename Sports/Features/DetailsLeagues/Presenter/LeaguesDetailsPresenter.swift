//
//  LeaguesDetailsPresenter.swift
//  Sports
//
//  Created by Macos on 16/05/2025.
//

import Foundation

class LeaguesDetailsPresenter{
    var upComingEvents :[Event]?
    var sport : String
    var latestEvents:[Event]?
    var todayLatestEvents:[Event]?
    var teams:[Standing]?
    var eventsVC : EventsViewController
    var league:Leagues
    let favCoreData = FavouritesDB.shared
    
    init(eventsVC: EventsViewController, sport : String, league:Leagues) {
        self.eventsVC = eventsVC
        self.sport = sport
        self.league = league
    }
    
    func fetchUpComingEvents(){
        
        let currentDate = Date()
        let calendar = Calendar.current
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        let formattedDate = formatter.string(from: currentDate)
        guard let nextWeeks = calendar.date(byAdding: .day, value: 10, to: currentDate) else { return
        }
        let nextWeeksFormattedDate = formatter.string(from: nextWeeks)
        
        Network.fetchData(sport: sport, quray: "met=Fixtures&leagueId=\(league.league_key)&from=\(formattedDate)&to=\(nextWeeksFormattedDate)"){
            [weak self](result : EventRespose?, error) in
            
            
            self?.upComingEvents = result?.result.filter{
                $0.event_final_result == "-"
            }
            self?.todayLatestEvents = result?.result.filter{
                $0.event_final_result != "-"
            }
            DispatchQueue.main.async {
                self?.eventsVC.upComingEvents = self?.upComingEvents ?? []
                self?.eventsVC.reloadData()
            }
        }
        
    }
    func fetchLeatestEvents(){
        
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
        
        Network.fetchData(sport: sport, quray: "met=Fixtures&leagueId=\(league.league_key)&to=\(yasterdayFormattedDate)&from=\(weekFormattedDate)"){
            [weak self] (result : EventRespose?, error) in
                self?.latestEvents = (self?.todayLatestEvents ?? []) + (result?.result ?? [])
                DispatchQueue.main.async {
                    self?.eventsVC.allLatestEvents = self?.latestEvents ?? []
                    self?.eventsVC.reloadData()
                }
            
        }
    }
    
    func getTeams(){
        if sport == "tennis"{
            Network.fetchData(sport: sport, quray: "met=Standings&league=ATP"){
                [weak self] (result : LeagueTeamsResponse<[TennisPlayers]>?, error) in
                print(result?.success ?? 1000)
                self?.teams = result?.result.map({$0.match()})
                DispatchQueue.main.async {
                    self?.eventsVC.teams = self?.teams ?? []
                    self?.eventsVC.reloadData()
                }
            }
        }
        else{
            Network.fetchData(sport: sport, quray: "met=Standings&leagueId=\(league.league_key)"){
                [weak self] (result : LeagueTeamsResponse<LeaguesTeamsResult>?, error) in
                self?.teams = result?.result.total.map({$0.match()})
                DispatchQueue.main.async {
                    self?.eventsVC.teams = self?.teams ?? []
                    self?.eventsVC.reloadData()
                }
            }
        }
        
    }
    
    func addToFav(){
        favCoreData.addToFav(league: league, sport: sport)
    }

    func deleteFromFavourites(leagueKey:Int){
        favCoreData.deleteFromFav(leagueKey: leagueKey)
    }
    
    func isFavLeague(league : Leagues){
        let isFav = favCoreData.isFavLeagues(league: league)
        eventsVC.isFavLeague(isFav: isFav)
    }
}
