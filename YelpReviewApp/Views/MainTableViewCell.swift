//
//  MainTableViewCell.swift
//  YelpReviewApp
//
//  Created by Chloe Qu on 2021-08-06.
//

import UIKit

class MainTableViewCell: UITableViewCell {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var rating: UILabel!
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var price: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photo.layer.cornerRadius = 5
        photo.clipsToBounds = true
    }
    
    func configure(with business: Business?) {
        if let business = business {
            name.text = business.name
            rating.text = String("Ratings: \(business.rating) / 5.0")
            count.text = "\(business.review_count) reviews"
            price.text = "Price: " + (business.price ?? "")
            if let image_url = URL(string:business.image_url) {
                photo.load(url: image_url)
            } else {
                photo.image = UIImage(named: "unavailable")
            }
            
        }
    }
}


