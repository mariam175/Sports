//
//  LeaugesViewController.swift
//  Sports
//
//  Created by Macos on 14/05/2025.
//

import UIKit
import SDWebImage
class LeaguesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {


    var presenter : LeaugesPresenter?
    var leagues : [Leagues]?

    var sport : String?
    @IBOutlet weak var leaguesTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()


        self.title = "Leagues"
        leaguesTable.delegate = self
        leaguesTable.dataSource = self
        leaguesTable.separatorStyle = .none
        let nib = UINib(nibName: "PlayersStaticCell", bundle: nil)
        leaguesTable.register(nib, forCellReuseIdentifier: "PlayersStaticCell")
        presenter = LeaugesPresenter(LVC: self)
        presenter?.sport = self.sport ?? ""
        presenter?.getData()

    }




    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return leagues?.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        guard let cell = tableView.dequeueReusableCell(withIdentifier: "PlayersStaticCell", for: indexPath) as? PlayersStaticCell else{
            return UITableViewCell()
        }


        if let league = leagues?[indexPath.row] {
            cell.PlayerName.text = league.league_name
        } else {
            cell.PlayerName.text = "No name"
        }

        if let imageUrl = presenter?.imageUrl(for: indexPath.row) {
            cell.PlayerImg.sd_setImage(with: imageUrl, placeholderImage: UIImage(named: "placeholder"))
        }else{
            cell.PlayerImg.image = UIImage(named: "placeholder")
        }
        

        return cell
        }




    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

//        let league = leagues?[indexPath.row]
        print("go to Details")
        let detalisLVC = EventsViewController(nibName: "EventsViewController", bundle: nil)
        detalisLVC.sport = self.sport
        detalisLVC.league = leagues?[indexPath.row]
        navigationController?.pushViewController(detalisLVC, animated: true)

    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10

    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear
        return view
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
