//
//  ViewController.swift
//  ShopifyMatchingGame
//
//  Created by Arjun Dureja on 2019-12-25.
//  Copyright © 2019 Arjun Dureja. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var matchedLabel: UILabel!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstCardIndex:IndexPath?
    var firstCard:Card?
    
    var matched = 0
    
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
            
            if firstCardIndex == nil {
                firstCardIndex = indexPath
                firstCard = cardArray[firstCardIndex!.row]
            }
            else {
                checkMatch(indexPath)
            }
        }
    }
    
    func checkMatch(_ secondCardIndex:IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstCardIndex!) as? CardCollectionViewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondCardIndex) as? CardCollectionViewCell
        
        let cardOne = cardArray[firstCardIndex!.row]
        let cardTwo = cardArray[secondCardIndex.row]
        
        if cardOne.imageName == cardTwo.imageName {
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.3) {
                self.matched += 1
                self.matchedLabel.text = "Matched: \(self.matched)"
            }
            
            if(checkWin()) {

                let alert = UIAlertController(title: "Congratulations!", message: "You Won", preferredStyle: .alert)
                
                let alertAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
                
                alert.addAction(alertAction)
            
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
                    self.present(alert, animated: true, completion: nil)
                }

            }
            
        }
        else {
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell?.flipBack()
            cardTwoCell?.flipBack()
        }
        
        firstCardIndex = nil
        firstCard = nil
    }
    
    func checkWin() -> Bool {
        for card in cardArray {
            if card.isMatched == false{
                return false
            }
        }
        return true
    }

    @IBAction func shuffleButton(_ sender: UIButton) {
        cardArray = model.shuffle(c: cardArray)
        if firstCard != nil {
            for index in collectionView.indexPathsForVisibleItems {
                if cardArray[index.row] === firstCard {
                    firstCardIndex = index
                }
            }
        }
        collectionView.reloadData()
    }
}


