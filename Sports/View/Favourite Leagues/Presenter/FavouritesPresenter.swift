//
//  FavouritesPresenter.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import Foundation

class FavouritesPresenter{
    let favDB = FavouritesDB.shared
    var favVC :FavTableViewController
    
    var favouriteLeagues : [FavouriteLeagues] = []
    init(favVC: FavTableViewController) {
        self.favVC = favVC
    }
    
    func getFavLeagues(){
        
        favouriteLeagues = favDB.getFavouriteLeagues()
        favVC.getData()
    }
  
    
}
