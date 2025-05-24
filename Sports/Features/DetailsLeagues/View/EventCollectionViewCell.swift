//
//  EventCollectionViewCell.swift
//  TestSport
//
//  Created by Macos on 16/05/2025.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var homeImage: UIImageView!
    @IBOutlet weak var homeName: UILabel!
    @IBOutlet weak var awayImage: UIImageView!
    
    @IBOutlet weak var awayName: UILabel!
    
    @IBOutlet weak var eventDate: UILabel!
    
    @IBOutlet weak var finalResult: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 12
        contentView.layer.borderWidth = 2
        homeImage.layer.cornerRadius = homeImage.frame.size.width / 2
        homeImage.clipsToBounds = true
        awayImage.layer.cornerRadius = awayImage.frame.size.width / 2
        awayImage.clipsToBounds = true
        contentView.layer.borderColor = UIColor.blue.cgColor
        contentView.backgroundColor =  UIColor(red: 229/255, green: 228/255, blue: 226/255, alpha: 1.0)
    }
    
    func configre(event : Event, sport : String){
        self.awayImage.sd_setImage(with: URL(string:event.away_team_logo ?? "placeholder"), placeholderImage: UIImage(named: Placeholder.placeholderImage(sport: sport)))
        self.awayName.text = event.event_away_team
        self.homeImage.sd_setImage(with: URL(string: event.home_team_logo ?? "placeholder"), placeholderImage: UIImage(named: Placeholder.placeholderImage(sport: sport)))
        self.homeName.text = event.event_home_team
        self.eventTime.text = event.event_time
        self.eventDate.text = event.event_date
        self.finalResult.text = event.event_final_result
        self.finalResult.isHidden = false
    }

}
