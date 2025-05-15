//
//  SportsViewController.swift
//  TestSport
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class SportsViewController: UIViewController ,UICollectionViewDataSource , UICollectionViewDelegate ,UICollectionViewDelegateFlowLayout{

    

    @IBOutlet weak var sportsCV: UICollectionView!
    var sports:[[String: String]] = [
        ["title": "Football", "image": "football"],
        ["title": "Basketball", "image": "basketball"],
        ["title": "Cricket", "image": "cricket"],
        ["title": "Tennis", "image": "tennis"]
    ]
    override func viewDidLoad() {
        super.viewDidLoad()
        sportsCV.dataSource = self
        sportsCV.delegate = self
        
        let cellNib = UINib(nibName: "SportCollectionViewCell", bundle: nil)
        sportsCV.register(cellNib, forCellWithReuseIdentifier: "sportCell")
        
        if let flowLayout = sportsCV.collectionViewLayout as? UICollectionViewFlowLayout {
               flowLayout.minimumInteritemSpacing = 10
               flowLayout.minimumLineSpacing = 12
               flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
           }
        
        // Do any additional setup after loading the view.
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sports.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sportCell", for: indexPath) as! SportCollectionViewCell
        cell.sportImage.image = UIImage(named: sports[indexPath.row]["image"] ?? "tennis")
        cell.sportName.text = sports[indexPath.row]["title"]
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (sportsCV.bounds.width - 30) / 2, height: (sportsCV.bounds.height - 30) / 2)
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
