//
//  EventsViewController.swift
//  TestSport
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class EventsViewController: UIViewController ,UICollectionViewDelegate, UICollectionViewDataSource , UICollectionViewDelegateFlowLayout{
   
    
    @IBOutlet weak var eventsCV: UICollectionView!
    @IBOutlet weak var leagueName: UILabel!
    
    @IBOutlet weak var favBtn: UIButton!
    
    var upComingEvents : [Event] = []
    var allLatestEvents : [Event] = []
    var teams : [Team] = []
    var preseter : LeaguesDetailsPresenter?
    var sport : String?
    var league : Leagues?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsCV.dataSource = self
        eventsCV.delegate = self

        let eventsCellNib = UINib(nibName: "EventCollectionViewCell", bundle: nil)
        eventsCV.register(eventsCellNib, forCellWithReuseIdentifier: "eventCell")
        
        let teamCellNib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        eventsCV.register(teamCellNib, forCellWithReuseIdentifier: "teamCell")
        guard let league = self.league else {
            return
        }
        preseter = LeaguesDetailsPresenter(eventsVC: self , sport: self.sport ?? "football" , league: league)

        preseter?.fetchUpComingEvents()
        preseter?.fetchLeatestEvents()
        preseter?.isFavLeague(league: league)
        
        print(upComingEvents.first?.event_away_team ?? "no")
        let layout = UICollectionViewCompositionalLayout { index , envorinment in
            switch index{
            case 0 :
                return self.incomingEvents()
            case 1:
                return self.latestEvents()
            default:
                return self.teamsSection()
            }
        }
        eventsCV.setCollectionViewLayout(layout, animated: true)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        leagueName.text = league?.league_name ?? "League"
    }
    func reloadData(){
        getTeams()
        eventsCV.reloadData()
    }
    
    func getTeams(){
        
        for i in upComingEvents{
            teams.append(Team(teamKey: i.away_team_key, teamLogo: i.away_team_logo))
            teams.append(Team(teamKey: i.home_team_key, teamLogo: i.home_team_logo))
        }
        for i in allLatestEvents{
            teams.append(Team(teamKey: i.away_team_key, teamLogo: i.away_team_logo))
            teams.append(Team(teamKey: i.home_team_key, teamLogo: i.home_team_logo))
        }
        var teamSet = Set<Int>()
        var uniteams = teams.filter{
            team in
            if (teamSet.contains(team.teamKey)){
                return false
            }
            else{
                teamSet.insert(team.teamKey)
            }
            return true
        }
        teams = uniteams
        
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return upComingEvents.count
        case 1:
            return allLatestEvents.count
        default:
            return teams.count
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamsCollectionViewCell
            cell.teamImage.sd_setImage(with: URL(string:teams[indexPath.row].teamLogo), placeholderImage: UIImage(named: "placeholder"))
            return cell
        }
        if (indexPath.section == 1){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath)
            as! EventCollectionViewCell
            cell.awayImage.sd_setImage(with: URL(string:allLatestEvents[indexPath.row].away_team_logo), placeholderImage: UIImage(named: "placeholder"))
            cell.awayName.text = allLatestEvents[indexPath.row].event_away_team
            cell.homeImage.sd_setImage(with: URL(string: allLatestEvents[indexPath.row].home_team_logo), placeholderImage: UIImage(named: "placeholder"))
            cell.homeName.text = allLatestEvents[indexPath.row].event_home_team
            cell.eventTime.text = allLatestEvents[indexPath.row].event_time
            cell.eventDate.text = allLatestEvents[indexPath.row].event_date
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath)
        as! EventCollectionViewCell
        cell.awayImage.sd_setImage(with: URL(string: upComingEvents[indexPath.row].away_team_logo), placeholderImage: UIImage(named: "placeholder"))
        cell.awayName.text = upComingEvents[indexPath.row].event_away_team
        cell.homeImage.sd_setImage(with: URL(string: upComingEvents[indexPath.row].home_team_logo), placeholderImage: UIImage(named: "placeholder"))
        cell.homeName.text = upComingEvents[indexPath.row].event_home_team
        cell.eventTime.text = upComingEvents[indexPath.row].event_time
        cell.eventDate.isHidden = true
        return cell
        
    }
 
    
    func incomingEvents() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 32, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
        
    }
    func latestEvents() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(200))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .none
        return section
        
    }
    func teamsSection() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .continuous
        return section
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let selectedTeam = teams[indexPath.row]
            print("Team Key: \(selectedTeam.teamKey)")
            let PSVC = PlayersScreenViewController(nibName: "PlayersScreenViewController", bundle: nil)
            PSVC.presenter = TeamDetailsPresenter(PSVC: PSVC, sport: self.sport ?? "football")
            PSVC.presenter?.fetchTeamDetails(teamId: selectedTeam.teamKey)
            navigationController?.pushViewController(PSVC, animated: true)

        }
    }
    
    func isFavLeague(isFav : Bool){
        if isFav{
            self.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }else{
            self.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    @IBAction func addLeagueToFav(_ sender: Any) {
        preseter?.addToFav()
        self.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
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
