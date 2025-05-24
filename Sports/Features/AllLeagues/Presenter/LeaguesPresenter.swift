//
//  LeaugesPresenter.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import Foundation

class LeaugesPresenter{

    var LVC :LeaguesViewController
    var leagues : [Leagues] = []
    var sport : String?

    init(LVC:LeaguesViewController){
        self.LVC = LVC
    }


    func getData(){

        Network.fetchData(sport: sport, quray: "met=Leagues"){
            [weak self] (response : LeaguesResponse? , error) in
            self?.leagues = response?.result ?? []

            DispatchQueue.main.async {
                self?.LVC.leagues = self?.leagues ?? []
                self?.LVC.activityIndicator.stopAnimating()
              self?.LVC.leaguesTable.reloadData()
            }
        }
    }

    func imageUrl(for index: Int) -> URL? {
        guard let logoString = leagues[index].league_logo else { return nil }
        return URL(string: logoString)
    }

}


