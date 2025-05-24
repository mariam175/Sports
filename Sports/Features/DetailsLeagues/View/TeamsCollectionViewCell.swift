//
//  TeamsCollectionViewCell.swift
//  TestSport
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var teamImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 2
        contentView.layer.borderColor = UIColor.blue.cgColor
    }
    func config(team : Standing, sport:String){
        self.teamImage.sd_setImage(with: URL(string:
                                                Config.teamImage(teamKey: team.teamKey, team: team.teamName, sport: sport)),
            placeholderImage: UIImage(named: Placeholder.placeholderImage(sport: sport)))
        self.teamName.text = team.teamName
    }

}
