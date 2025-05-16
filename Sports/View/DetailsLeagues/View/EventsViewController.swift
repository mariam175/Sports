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
    override func viewDidLoad() {
        super.viewDidLoad()
        eventsCV.dataSource = self
        eventsCV.delegate = self

        let eventsCellNib = UINib(nibName: "EventCollectionViewCell", bundle: nil)
        eventsCV.register(eventsCellNib, forCellWithReuseIdentifier: "eventCell")
        
        let teamCellNib = UINib(nibName: "TeamsCollectionViewCell", bundle: nil)
        eventsCV.register(teamCellNib, forCellWithReuseIdentifier: "teamCell")
        
        let layout = UICollectionViewCompositionalLayout { index , envorinment in
            switch index{
            case 0 :
                return self.incomingEvents()
            case 1:
                return self.latestEvents()
            default:
                return self.teams()
            }
        }
        eventsCV.setCollectionViewLayout(layout, animated: true)
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if (indexPath.section == 2){
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "teamCell", for: indexPath) as! TeamsCollectionViewCell
            cell.teamImage.image = UIImage(named: "tennis")
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "eventCell", for: indexPath)
        as! EventCollectionViewCell
        cell.awayImage.image = UIImage(named: "tennis")
        cell.awayName.text = "Tennis"
        cell.homeImage.image = UIImage(named: "football")
        cell.homeName.text = "Football"
        return cell
        
    }
 
    
    func incomingEvents() -> NSCollectionLayoutSection{
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 16)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
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

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(160))
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 16, trailing: 0)
        section.orthogonalScrollingBehavior = .none
        return section
        
    }
    func teams() -> NSCollectionLayoutSection{
        
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
