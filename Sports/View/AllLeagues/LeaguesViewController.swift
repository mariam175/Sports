//
//  LeaugesViewController.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import UIKit

class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var presenter : LeaugesPresenter?
    var leagues : [Leagues]?


    @IBOutlet weak var leaguesTable: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "Leagues"
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
        presenter = LeaugesPresenter(LVC: self)
        presenter?.getData()

    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cellofLeagues", for: indexPath) as? LeaguesViewCell else{
            return UITableViewCell()
        }


        if let league = leagues?[indexPath.row] {
            cell.nameOfLeague.text = league.league_name
        } else {
            cell.nameOfLeague.text = "No name"
        }
        return cell
        }


    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let league = leagues?[indexPath.row]
        print("go to Details")
        let detalisLVC = storyboard?.instantiateViewController(withIdentifier: "DetailsLeaguesViewController") as! DetailsLeaguesViewController
        navigationController?.pushViewController(detalisLVC, animated: true)

    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
