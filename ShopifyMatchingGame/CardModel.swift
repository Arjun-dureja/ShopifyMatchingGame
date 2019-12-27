//
//  CardModel.swift
//  ShopifyMatchingGame
//
//  Created by Arjun Dureja on 2019-12-25.
//  Copyright © 2019 Arjun Dureja. All rights reserved.
//

import Foundation

class CardModel {
    
    func getCards() -> [Card] {
        
        var cards = [Card]()
        var nums = [Int]()
        var randNum = 0
        
        for _ in 1...10 {
            repeat {
                randNum = Int.random(in: 1...50)
            } while(nums.contains(randNum))
            nums.append(randNum)
            print("Random number: \(randNum)")
            
            let cardOne = Card()
            cardOne.imageName = "card\(randNum)"
            
            cards.append(cardOne)
            
            let cardTwo = Card()
            cardTwo.imageName = "card\(randNum)"
            
            cards.append(cardTwo)
        }
        
        print("Number of cards: \(cards.count)")
        return cards
    }
}
