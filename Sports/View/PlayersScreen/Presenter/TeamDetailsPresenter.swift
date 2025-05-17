//
//  TeamDetailsPresenter.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import Foundation
class TeamDetailsPresenter{
    var PSVC :PlayersScreenViewController
    var team: TeamDetails?
    var sport : String?



    init(PSVC:PlayersScreenViewController,sport:String){
        self.PSVC = PSVC
        self.sport = sport
    }


    func fetchTeamDetails(teamId: Int){
        Network.getTeamDetails(teamId: teamId, sport: sport ?? "") { [weak self] response in
            self?.team = response?.result.first
            DispatchQueue.main.async {
                self?.PSVC.team = self?.team
                self?.PSVC.PlayersTable.reloadData()
            }
        }
    }



    func imageUrl() -> URL? {
        guard let logoString = team?.team_logo else { return nil }
        return URL(string: logoString)
    }
}

