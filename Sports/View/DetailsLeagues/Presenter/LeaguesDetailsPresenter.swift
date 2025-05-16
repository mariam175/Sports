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
    var eventsVC : EventsViewController
    var league:Int
    
    init(eventsVC: EventsViewController, sport : String, league:Int) {
        self.eventsVC = eventsVC
        self.sport = sport
        self.league = league
    }
    func fetchUpComingEvents(){
        Network.getUpComingEvents(leagueId: league, sport: sport){
            [weak self] result in
            self?.upComingEvents = result?.result
            DispatchQueue.main.async {
                self?.eventsVC.upComingEvents = self?.upComingEvents ?? []
                self?.eventsVC.reloadData()
            }
        }
    }
    func fetchLeatestEvents(){
        Network.getUpLatestEvents(leagueId: league, sport: sport){
            [weak self] result in
            self?.latestEvents = result?.result
            DispatchQueue.main.async {
                self?.eventsVC.allLatestEvents = self?.latestEvents ?? []
                self?.eventsVC.reloadData()
            }
        }
    }
}
