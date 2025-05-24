//
//  FavouritesPresenter.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import Foundation
import Network
import SystemConfiguration

class FavouritesPresenter{
    private let networkMonitor = NWPathMonitor()
    private var isConnected = false
    let favDB = FavouritesDB.shared
   weak var favVC :FavTableViewController?
    var favouriteLeagues : [FavouriteLeagues] = []


    init(favVC: FavTableViewController ) {
        self.favVC = favVC
        setupNetworkMonitoring()
    }

    func getFavLeagues() {
        if isConnected {
            print("Internet available")
            favouriteLeagues = favDB.getFavouriteLeagues()
        } else {
            print("No internet")
            favouriteLeagues = favDB.getFavouriteLeagues()
        }
        DispatchQueue.main.async {
            self.favVC?.getData()
        }
    }


    func deleteFromFavourites(leagueKey:Int){
        favDB.deleteFromFav(leagueKey: leagueKey)
    }

     func setupNetworkMonitoring() {
         networkMonitor.pathUpdateHandler = { [weak self] path in
             self?.isConnected = (path.status == .satisfied)
             if path.status == .satisfied {
                 DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                     self?.getFavLeagues()
                 }
             }
         }
        let queue = DispatchQueue(label: "NetworkMonitor")
        networkMonitor.start(queue: queue)
        }

    func isInternetAvailable() -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)

        guard let defaultRouteReachability = withUnsafePointer(to: &zeroAddress, {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {
                SCNetworkReachabilityCreateWithAddress(nil, $0)
            }
        }) else {
            return false
        }

        var flags: SCNetworkReachabilityFlags = []
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags) {
            return false
        }

        return flags.contains(.reachable) && !flags.contains(.connectionRequired)
    }

    }







