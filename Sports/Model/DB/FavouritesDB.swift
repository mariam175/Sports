//
//  FavouritesDB.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import Foundation
import UIKit
import CoreData

class FavouritesDB{
    let favEntity = "FavLeagues"
    let manager : NSManagedObjectContext?
    static let shared = FavouritesDB()
    
    private init(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
         manager = appDelegate.persistentContainer.viewContext
    }
    
//    func addToFav(league : Leagues , sport : String){
//        guard let manager = manager else{
//            return
//        }
//        let entity = NSEntityDescription.entity(forEntityName: favEntity, in: manager)
//        let insertFavs = NSManagedObject(entity: entity!, insertInto: manager)
//        insertFavs.setValue(league.league_key, forKey: "leagueKey")
//        insertFavs.setValue(league.league_name, forKey: "leagueName")
//        insertFavs.setValue(league.league_logo, forKey: "leagueLogo")
//        insertFavs.setValue(sport, forKey: "sport")
//        
//        do{
//            try manager.save()
//            print("Saved \(league.league_name) with \(sport)")
//            
//        }catch{
//            print("Sorry .... Fail to save")
//        }
//    }

    func addToFav(league: Leagues, sport: String) {
        guard let manager = manager else {
            return
        }

        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", league.league_key)

        do {
            let existing = try manager.fetch(fetchRequest)
            if !existing.isEmpty {
                return 

            }

            let entity = NSEntityDescription.entity(forEntityName: favEntity, in: manager)
            let insertFavs = NSManagedObject(entity: entity!, insertInto: manager)
            insertFavs.setValue(league.league_key, forKey: "leagueKey")
            insertFavs.setValue(league.league_name, forKey: "leagueName")
            insertFavs.setValue(league.league_logo, forKey: "leagueLogo")
            insertFavs.setValue(sport, forKey: "sport")

            try manager.save()
            print("Saved \(league.league_name) with \(sport)")
        } catch {
            print("Sorry .... Fail to save")
        }
    }


    func getFavouriteLeagues() -> [FavouriteLeagues]{
        guard let manager = manager else{
            return []
        }
        let fetchRequest :NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        do{
            let favLegues = try manager.fetch(fetchRequest)
            var leagues : [FavouriteLeagues] = []
            for i in favLegues {
                leagues.append(
                    FavouriteLeagues(leagueLogo: i.leagueLogo ?? "",
                                     leagueName: i.leagueName ?? "",
                                     leagueKey: Int(truncating: i.leagueKey ?? 0),
                                     sport: i.sport ?? "")
                )
            }
            return leagues
            
        }catch{
            print("Fail to Fetch Data")
        }
        return []
    }
    
    func isFavLeagues(league : Leagues)->Bool{
        var isFav = false
        let favs = getFavouriteLeagues()
        for i in favs{
            if league.league_key == i.leagueKey {
                isFav = true
                break
            }
        }
        return isFav
    }


    func deleteFromFav(leagueKey : Int){
        guard let manager = manager else {
            return
        }

        let fetchRequest: NSFetchRequest<FavLeagues> = FavLeagues.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey == %d", leagueKey)

        do {
            let results = try manager.fetch(fetchRequest)
            for object in results {
                manager.delete(object)
            }
            try manager.save()
            print("Deleted league with key: \(leagueKey)")
        } catch {
            print("Failed to delete league: \(error.localizedDescription)")
        }
    }

}
