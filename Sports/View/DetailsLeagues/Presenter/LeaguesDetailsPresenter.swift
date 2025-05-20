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
    var teams:[LeagueTeams]?
    var eventsVC : EventsViewController
    var league:Leagues
    let favCoreData = FavouritesDB.shared
    
    init(eventsVC: EventsViewController, sport : String, league:Leagues) {
        self.eventsVC = eventsVC
        self.sport = sport
        self.league = league
    }
    
    func fetchUpComingEvents(){
        
        Network.getUpComingEvents(leagueId: league.league_key, sport: sport){
            [weak self] result in
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
        Network.getUpLatestEvents(leagueId: league.league_key, sport: sport){
            [weak self] result in
            self?.latestEvents = (self?.todayLatestEvents ?? []) + (result?.result ?? [])
            DispatchQueue.main.async {
                self?.eventsVC.allLatestEvents = self?.latestEvents ?? []
                self?.eventsVC.reloadData()
            }
        }
    }
    
    func getTeams(){
        Network.getTeams(leagueId: league.league_key, sport: sport){ [weak self]
            result in
            self?.teams = result?.result.total
            DispatchQueue.main.async {
                self?.eventsVC.teams = self?.teams ?? []
                self?.eventsVC.reloadData()
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
