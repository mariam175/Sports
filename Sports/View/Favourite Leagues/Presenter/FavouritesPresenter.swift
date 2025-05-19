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
    private var reachability: Reachability?
    weak var delegate: NetworkStatusDelegate?

    var favouriteLeagues : [FavouriteLeagues] = []
    init(favVC: FavTableViewController) {
        self.favVC = favVC
        setupReachability()
    }

    func getFavLeagues(){

        favouriteLeagues = favDB.getFavouriteLeagues()
        favVC?.getData()
    }

    func deleteFromFavourites(leagueKey:Int){
        favDB.deleteFromFav(leagueKey: leagueKey)
    }

    private func setupReachability() {
            do {
                reachability = try Reachability()
                NotificationCenter.default.addObserver(
                    self,
                    selector: #selector(reachabilityChanged),
                    name: .reachabilityChanged,
                    object: reachability
                )
                try reachability?.startNotifier()
            } catch {
                print("Unable to start notifier")
            }
        }

    @objc private func reachabilityChanged(note: Notification) {
            guard let reachability = note.object as? Reachability else { return }

            let isConnected = (reachability.connection != .unavailable && reachability.connection != .none)
            delegate?.networkStatusChanged(isConnected: isConnected)
        }

    func isConnectedToInternet() -> Bool {
        return reachability?.connection != .unavailable && reachability?.connection != .none
    }

        deinit {
            reachability?.stopNotifier()
            NotificationCenter.default.removeObserver(self, name: .reachabilityChanged, object: reachability)
        }

  
    
}
