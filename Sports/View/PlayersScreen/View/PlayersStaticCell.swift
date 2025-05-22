//
//  PlayersStaticCell.swift
//  Sports
//
//  Created by Macos on 17/05/2025.
//

import Foundation
import UIKit

class PlayersStaticCell:UITableViewCell{

    @IBOutlet weak var PlayerImg: UIImageView!
    @IBOutlet weak var PlayerName: UILabel!
    override func layoutSubviews() {
         super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16))
        PlayerImg.layer.cornerRadius = PlayerImg.frame.size.width / 2
        PlayerImg.clipsToBounds = true
        
        contentView.layer.cornerRadius = 12
            contentView.layer.borderWidth = 1.0
        contentView.layer.borderColor = UIColor.green.cgColor
            contentView.clipsToBounds = true

     }
}
