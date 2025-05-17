//
//  PlayersScreenViewController.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import UIKit

class PlayersScreenViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var PlayersTable: UITableView!

    var presenter: TeamDetailsPresenter!
    var team: TeamDetails?
    var sport : String?
    var selectedTeam :Int?

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
            return team?.players?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {

        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "TeamLogo", for: indexPath) as! TeamLogo
            if let logo = team?.team_logo, let url = URL(string: logo) {
                cell.TeamImg.sd_setImage(with: url)
            }
            return cell

        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "CoachStaticCell", for: indexPath) as! CoachStaticCell
            if let coach = team?.coaches?.first {
                        cell.CoachName.text = coach.coach_name
                cell.CoachImg.image = UIImage(named: "coach")

                cell.CoachImg.sd_setImage(with: URL(string: coach.coach_image ?? ""), placeholderImage: UIImage(named: "coach"))
                   }else{
                       cell.CoachImg.image = UIImage(named: "coach")
                   }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersStaticCell", for: indexPath) as! PlayersStaticCell


            if let player = team?.players?[indexPath.row] {
                       cell.PlayerName.text = player.player_name
                cell.PlayerImg.image = UIImage(named: "player")

                cell.PlayerImg.sd_setImage(with: URL(string: player.player_image ?? ""), placeholderImage: UIImage(named: "player"))
                   }else{
                       cell.PlayerImg.image = UIImage(named: "player")
                   }

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
