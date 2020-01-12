//
//  HomeViewController.swift
//  ShopifyMatchingGame
//
//  Created by Arjun Dureja on 2020-01-01.
//  Copyright © 2020 Arjun Dureja. All rights reserved.
//

import UIKit

let storyBoard = UIStoryboard(name: "Main", bundle: nil)
class HomeViewController: UIViewController {

    let vc = storyBoard.instantiateViewController(identifier: "game") as! ViewController
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //Method called when play button is pressed
    @IBAction func playButton(_ sender: UIButton) {
        let sliderVal = Int(slider.value)
        
        //Update the grid size using the slider
        switch sliderVal {
        case 2:
            vc.gridSize = 15
        case 3:
            vc.gridSize = 20
        default:
            vc.gridSize = 10
        }
        
        //Switch to game view controller
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func gridSlider(_ sender: UISlider) {
        slider.value = roundf(slider.value)
    }
}
