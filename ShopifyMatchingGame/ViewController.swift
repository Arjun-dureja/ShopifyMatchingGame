//
//  ViewController.swift
//  ShopifyMatchingGame
//
//  Created by Arjun Dureja on 2019-12-25.
//  Copyright © 2019 Arjun Dureja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstCard:IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cardArray = model.getCards()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView?.backgroundColor = UIColor.clear
        self.collectionView?.backgroundView = UIView(frame: CGRect.zero)
        
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        cell.setCard(card)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! CardCollectionViewCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            cell.flip()
            card.isFlipped = true
            
            if firstCard == nil {
                firstCard = indexPath
            }
            else {
                checkMatch(indexPath)
            }
        }
    }
    
    func checkMatch(_ secondCard:IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstCard!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondCard) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstCard!.row]
        let cardTwo = cardArray[secondCard.row]
        
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
        }
        else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        firstCard = nil
    }
    
    
}


