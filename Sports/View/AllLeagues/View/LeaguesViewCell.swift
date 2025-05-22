//
//  LeaguesViewCell.swift
//  Sports
//
//  Created by Macos on 15/05/2025.
//

import UIKit

class LeaguesViewCell: UITableViewCell {



    @IBOutlet weak var logoOfLeague: UIImageView!
    
    @IBOutlet weak var nameOfLeague: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    override func layoutSubviews() {
         super.layoutSubviews()

        logoOfLeague.layer.cornerRadius = logoOfLeague.frame.size.width / 2
        logoOfLeague.clipsToBounds = true
        
        contentView.layer.cornerRadius = 12
            contentView.layer.borderWidth = 1.0
            contentView.layer.borderColor = UIColor.lightGray.cgColor
            contentView.clipsToBounds = true

     }


}
