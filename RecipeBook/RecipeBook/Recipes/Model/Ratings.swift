//
//  Ratings.swift
//  RecipeBook
//
//  Created by Ryan Sheh on 3/2/18.
//  Copyright © 2018 Ryan Sheh. All rights reserved.
//

import Foundation
import UIKit

class Ratings {
    @IBOutlet weak var firstStar: UIImageView!
    @IBOutlet weak var secondStar: UIImageView!
    @IBOutlet weak var thirdStar: UIImageView!
    @IBOutlet weak var fourthStar: UIImageView!
    @IBOutlet weak var fifthStar: UIImageView!
    
    let fullStarImage:  UIImage = UIImage(named: "starFull.png")!
    let halfStarImage:  UIImage = UIImage(named: "starHalf.png")!
    let emptyStarImage: UIImage = UIImage(named: "starEmpty.png")!
    
    func getStarImage(starNumber: Double, forRating rating: Double) -> UIImage {
        if rating >= starNumber {
            return fullStarImage
        } else if rating + 0.5 == starNumber {
            return halfStarImage
        } else {
            return emptyStarImage
        }
    }
    
    func setRating(rating: Double) {
        firstStar.image = getStarImage(starNumber: 1, forRating: rating)
        secondStar.image = getStarImage(starNumber: 2, forRating: rating)
        thirdStar.image = getStarImage(starNumber: 3, forRating: rating)
        fourthStar.image = getStarImage(starNumber: 4, forRating: rating)
//        fifthStar.image = getStarImage(starNumber: 5, forRating: rating)
    }
}
