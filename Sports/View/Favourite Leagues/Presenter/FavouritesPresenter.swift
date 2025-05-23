//
//  FavouritesPresenter.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import Foundation
import Reachability

protocol NetworkStatusDelegate: AnyObject {
    func networkStatusChanged(isConnected: Bool)
}

class FavouritesPresenter{
    let favDB = FavouritesDB.shared
   weak var favVC :FavTableViewController?
    weak var delegate: NetworkStatusDelegate?
    var favouriteLeagues : [FavouriteLeagues] = []
    var reachabilityService: NetworkObserver?


    init(favVC: FavTableViewController, delegate: NetworkStatusDelegate?, reachabilityService: NetworkObserver) {
        self.favVC = favVC
        self.delegate = delegate
        self.reachabilityService = reachabilityService
    }

    func getFavLeagues(){

        favouriteLeagues = favDB.getFavouriteLeagues()
        favVC?.getData()
    }

    func deleteFromFavourites(leagueKey:Int){
        favDB.deleteFromFav(leagueKey: leagueKey)
    }




    var isConnected: Bool {
        return reachabilityService?.isConnectedToInternet() ?? false
    }



}
