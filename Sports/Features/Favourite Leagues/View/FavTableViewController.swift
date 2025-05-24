//
//  FavTableViewController.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class FavTableViewController: UITableViewController {
    var favouriteLeagues : [FavouriteLeagues] = []
    var presenter : FavouritesPresenter?
    var sport : String?
    var wantToDelete:Bool?

    override func viewDidLoad() {
        super.viewDidLoad()
        let favCell = UINib(nibName: "FavouritesTableViewCell", bundle: nil)
        tableView.register(favCell, forCellReuseIdentifier: "favCell")
        presenter = FavouritesPresenter(favVC: self)
        self.title = "Favourite Leagues"


    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.getFavLeagues()

    }

    func getData(){
        favouriteLeagues = presenter?.favouriteLeagues ?? []
        tableView.reloadData()

    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return favouriteLeagues.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath) as! FavouritesTableViewCell
        cell.favImage.sd_setImage(with: URL(string: favouriteLeagues[indexPath.row].leagueLogo), placeholderImage: UIImage(named: "placeholder"))
        cell.favLeaguesName.text = favouriteLeagues[indexPath.row].leagueName
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10

    }

    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */


    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let leagueToDelete = favouriteLeagues[indexPath.row]
            showDeleteAlert(indexPath: indexPath, leagueKey: leagueToDelete.leagueKey)


        } else if editingStyle == .insert {
            print(" insert")
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let presenter = presenter {
              if presenter.isInternetAvailable() {
            let eventsVC = EventsViewController(nibName: "EventsViewController", bundle: nil)
            eventsVC.sport = sport

            let selectedLeague = Leagues(
                league_key: favouriteLeagues[indexPath.row].leagueKey,
                league_name: favouriteLeagues[indexPath.row].leagueName,
                league_logo: favouriteLeagues[indexPath.row].leagueLogo
            )
            eventsVC.league = selectedLeague

            navigationController?.pushViewController(eventsVC, animated: true)
        }else{
            showNoInternetAlert()
        }
        }
    }


    func showNoInternetAlert() {
        let alert = UIAlertController(title: "Error", message: "Make sure the internet is connected", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "OK", style: .default,  handler: nil))


        self.present(alert, animated: true, completion: nil)


    }




    func showDeleteAlert(indexPath: IndexPath, leagueKey: Int) {
        let alert = UIAlertController(title: "Delete League", message: "Do you want to delete this league?", preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { _ in
            self.presenter?.favDB.deleteFromFav(leagueKey: leagueKey)
            self.favouriteLeagues.remove(at: indexPath.row)
            self.tableView.deleteRows(at: [indexPath], with: .fade)
        }))

        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))

        self.present(alert, animated: true, completion: nil)

    }
        func retryNetworkRequest() {

            print("try again")
        }






        /*
         // Override to support rearranging the table view.
         override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

         }
         */

        /*
         // Override to support conditional rearranging of the table view.
         override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
         // Return false if you do not want the item to be re-orderable.
         return true
         }
         */

        /*
         // MARK: - Navigation

         // In a storyboard-based application, you will often want to do a little preparation before navigation
         override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
         // Get the new view controller using segue.destination.
         // Pass the selected object to the new view controller.
         }
         */

    }

