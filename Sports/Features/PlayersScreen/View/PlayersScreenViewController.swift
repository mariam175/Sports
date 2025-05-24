//
//  PlayersScreenViewController.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import UIKit

class PlayersScreenViewController: UIViewController,UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var PlayersTable: UITableView!

    @IBOutlet weak var teamLogo: UIImageView!
    var presenter: TeamDetailsPresenter!
    var activityIndicator: UIActivityIndicatorView!
    var team: TeamDetails?
    var sport : String?
    var selectedTeam :Int?
    var teamKey : Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Team Details"
        PlayersTable.separatorStyle = .none
        PlayersTable.register(UINib(nibName: "TeamLogo", bundle: nil), forCellReuseIdentifier: "TeamLogo")
        PlayersTable.register(UINib(nibName: "CoachStaticCell", bundle: nil), forCellReuseIdentifier: "CoachStaticCell")
           PlayersTable.register(UINib(nibName: "PlayersStaticCell", bundle: nil), forCellReuseIdentifier: "PlayersStaticCell")
        presenter = TeamDetailsPresenter(PSVC: self, sport: self.sport ?? "football")
        presenter?.fetchTeamDetails(teamId: teamKey ?? 0)
        PlayersTable.delegate = self
        PlayersTable.dataSource = self
        
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

       
    }

    func reloadTeamData(){
        teamLogo.sd_setImage(with: URL(string: team?.team_logo ?? "placeholder"), placeholderImage: UIImage(named: "placeholder"))
        PlayersTable.reloadData()
        activityIndicator.stopAnimating()
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        default:
            return team?.players?.count ?? 0
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch indexPath.section {


        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersStaticCell", for: indexPath) as! PlayersStaticCell
            if let coach = team?.coaches?.first {
                cell.PlayerName.text = coach.coach_name
                cell.PlayerImg.image = UIImage(named: "playerPlaceholder")

                cell.PlayerImg.sd_setImage(with: URL(string: coach.coach_image ?? ""), placeholderImage: UIImage(named: "playerPlaceholder"))
                   }else{
                       cell.PlayerImg.image = UIImage(named: "playerPlaceholder")
                   }
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersStaticCell", for: indexPath) as! PlayersStaticCell


            if let player = team?.players?[indexPath.row] {
                       cell.PlayerName.text = player.player_name
                cell.PlayerImg.image = UIImage(named: "playerPlaceholder")

                cell.PlayerImg.sd_setImage(with: URL(string: player.player_image ?? ""), placeholderImage: UIImage(named: "playerPlaceholder"))
                   }else{
                       cell.PlayerImg.image = UIImage(named: "playerPlaceholder")
                   }

            return cell
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "Coachs"

        default:
            return "Players"
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
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
