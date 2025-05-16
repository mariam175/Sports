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
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        contentView.layer.cornerRadius = 12
        contentView.backgroundColor =  UIColor(red: 229/255, green: 228/255, blue: 226/255, alpha: 1.0)
    }

}
