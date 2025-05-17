//
//  PlayersScreenViewController.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import UIKit

class PlayersScreenViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var PlayersTable: UITableView!

    struct Player {
        let name: String
        let imageName: String
    }

    let players: [Player] = [
        Player(name: "Cristiano Ronaldo", imageName: "ronaldo"),
        Player(name: "Lionel Messi", imageName: "messi"),
        Player(name: "Mohamed Salah", imageName: "salah")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        PlayersTable.register(UINib(nibName: "TeamLogo", bundle: nil), forCellReuseIdentifier: "TeamLogo")
        PlayersTable.register(UINib(nibName: "CoachStaticCell", bundle: nil), forCellReuseIdentifier: "CoachStaticCell")
           PlayersTable.register(UINib(nibName: "PlayersStaticCell", bundle: nil), forCellReuseIdentifier: "PlayersStaticCell")
        PlayersTable.delegate = self
        PlayersTable.dataSource = self
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0,1:
            return 1
        default:
            return players.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let player = players[indexPath.row]
        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamLogo", for: indexPath) as! TeamLogo
            cell.TeamImg.image = UIImage(named: "placeholder")
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoachStaticCell", for: indexPath) as! CoachStaticCell
            cell.CoachImg.image = UIImage(named: "placeholder")
            cell.CoachName.text = player.name
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersStaticCell", for: indexPath) as! PlayersStaticCell

            cell.PlayerName.text = player.name
            cell.PlayerImg.image = UIImage(named: "placeholder")
            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return nil

        case 1:
            return "Coachs"

        default:
            return "Players"
        }
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
