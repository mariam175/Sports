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
    
}
