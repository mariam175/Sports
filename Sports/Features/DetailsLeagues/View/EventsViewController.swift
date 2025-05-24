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
    var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var favBtn: UIButton!
    
    var upComingEvents : [Event] = []
    var allLatestEvents : [Event] = []
    var teams : [Standing] = []
    var preseter : LeaguesDetailsPresenter?
    var sport : String?
    var league : Leagues?
    var isFavouriteLeague: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        eventsCV.dataSource = self
        eventsCV.delegate = self

        let eventsCellNib = UINib(nibName: "EventCollectionViewCell", bundle: nil)
        eventsCV.register(eventsCellNib, forCellWithReuseIdentifier: "eventCell")
        
        let teamCellNib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        eventsCV.register(teamCellNib, forCellWithReuseIdentifier: "teamCell")
        
        let notFoundCellNib = UINib(nibName: "PlaceholderCollectionViewCell", bundle: nil)
        eventsCV.register(notFoundCellNib, forCellWithReuseIdentifier: "NotFoundCell")
        
        let headerNib = UINib(nibName: "HeaderCollectionReusableView", bundle: nil)
        eventsCV.register(headerNib, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        
        guard let league = self.league else {
            return
        }
        preseter = LeaguesDetailsPresenter(eventsVC: self , sport: self.sport ?? "football" , league: league)

        preseter?.fetchUpComingEvents()
        preseter?.fetchLeatestEvents()
        preseter?.getTeams()
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
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
    }
    override func viewWillAppear(_ animated: Bool) {
        leagueName.text = league?.league_name ?? "League"
    }
    func reloadData(){
        eventsCV.reloadData()
        activityIndicator.stopAnimating()
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return max(upComingEvents.count, 1)
        case 1:
            return max(allLatestEvents.count, 1)
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
            
            cell.config(team: teams[indexPath.row], sport: sport ?? "football")
            return cell
            
        }
        
        if (indexPath.section == 1){
            
           if !allLatestEvents.isEmpty {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath)
               as! EventCollectionViewCell
            cell.configre(event: allLatestEvents[indexPath.row])
               return cell
           }else{
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotFoundCell", for: indexPath)
               as! PlaceholderCollectionViewCell
               return cell
           }
        }
        
       
        
        if !upComingEvents.isEmpty{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath)
            as! EventCollectionViewCell
        cell.configre(event: upComingEvents[indexPath.row])
        cell.finalResult.isHidden = true
            return cell
        }
        else{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NotFoundCell", for: indexPath)
            as! PlaceholderCollectionViewCell
            return cell
        }
        
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
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
        let headerSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                                    heightDimension: .absolute(44))
            let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: headerSize,
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top)
            section.boundarySupplementaryItems = [sectionHeader]
        return section
        
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 2 {
            let selectedTeam = teams[indexPath.row]
            print("Team Key: \(selectedTeam.teamKey)")
            let PSVC = PlayersScreenViewController(nibName: "PlayersScreenViewController", bundle: nil)
            PSVC.teamKey = selectedTeam.teamKey
            navigationController?.pushViewController(PSVC, animated: true)

        }
    }
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionHeader{
            let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as! HeaderCollectionReusableView
            switch indexPath.section {
                   case 0:
                header.header.text = upComingEvents.isEmpty ? "No Upcoming Events" : "Upcoming Events"
                   case 1:
                header.header.text = allLatestEvents.isEmpty ? "No Latest Events" : "Latest Events"
                   case 2:
                header.header.text = teams.isEmpty ? "No Teams" : "Teams"
                   default:
                header.header.text = ""
                   }
                   return header
        }
        return UICollectionReusableView()
    }
    
    func isFavLeague(isFav : Bool){
        isFavouriteLeague = isFav
        if isFav{
            self.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        }else{
            self.favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    
    @IBAction func addLeagueToFav(_ sender: Any) {
        if isFavouriteLeague {
            guard let leagueToDelete = league?.league_key else { return }
            preseter?.deleteFromFavourites(leagueKey: leagueToDelete)
            isFavouriteLeague = false
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }else{
            preseter?.addToFav()
            isFavouriteLeague = true
            self.favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        }


    }
    func placeholderEvents(cell : EventCollectionViewCell){
        switch sport{
        case "football":
            cell.homeImage.image = UIImage(named: "footballPlaceholder")
            cell.awayImage.image = UIImage(named: "footballPlaceholder")
        case "cricket":
            cell.homeImage.image = UIImage(named: "cricketPlaceholder")
            cell.awayImage.image = UIImage(named: "cricketPlaceholder")
        case "basketball":
            cell.homeImage.image = UIImage(named: "basketballPlaceholder")
            cell.awayImage.image = UIImage(named: "basketballPlaceholder")
        default:
            cell.homeImage.image = UIImage(named: "tennisPlaceholder")
            cell.awayImage.image = UIImage(named: "tennisPlaceholder")
        }
        cell.homeName.text = "No Team"
        cell.awayName.text = "No Team"
        cell.finalResult.text = "0 - 0"
        cell.eventDate.isHidden = true
        cell.eventTime.isHidden = true
    }
    func placeholderCell(_ collectionView: UICollectionView, _ indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "No data-cuate")
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        cell.contentView.addSubview(imageView)
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: cell.contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: cell.contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100)
        ])
        
        return cell
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
