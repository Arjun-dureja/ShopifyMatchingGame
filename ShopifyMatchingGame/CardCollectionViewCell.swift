//
//  CardCollectionViewCell.swift
//  ShopifyMatchingGame
//
//  Created by Arjun Dureja on 2019-12-26.
//  Copyright © 2019 Arjun Dureja. All rights reserved.
//

import UIKit

class CardCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backImageView: UIImageView!
    
    var card:Card?
    
    func setCard(_ card:Card) {
        self.card = card
        
        frontImageView.image = UIImage(named: card.imageName)
        
        if card.isFlipped == true {
            UIView.transition(from: backImageView, to: frontImageView, duration: 0, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
        }
        else {
            UIView.transition(from: frontImageView, to: backImageView, duration: 0, options: [.showHideTransitionViews, .transitionFlipFromRight], completion: nil)
        }

    }
    
    func flip() {
        UIView.transition(from: backImageView, to: frontImageView, duration: 0.3, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    
    }
    
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            UIView.transition(from: self.frontImageView, to: self.backImageView, duration: 0.3, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    
}
