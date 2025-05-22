//
//  FavouritesTableViewCell.swift
//  Sports
//
//  Created by Macos on 18/05/2025.
//

import UIKit

class FavouritesTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    @IBOutlet weak var favLeaguesName: UILabel!
    
    @IBOutlet weak var favImage: UIImageView!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    override func layoutSubviews() {
         super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        favImage.layer.cornerRadius = favImage.frame.size.width / 2
        favImage.clipsToBounds = true
        
        contentView.layer.cornerRadius = 12
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            contentView.clipsToBounds = true

     }
    
}
