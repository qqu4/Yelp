//
//  DetailTableViewCell.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-07.
//

import UIKit

class DetailTableViewCell: UITableViewCell {
    @IBOutlet weak var photo: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = 5
        photo.clipsToBounds = true
    }
}
