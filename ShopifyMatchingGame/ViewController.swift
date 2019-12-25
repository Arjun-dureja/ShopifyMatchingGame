//
//  ViewController.swift
//  ShopifyMatchingGame
//
//  Created by Arjun Dureja on 2019-12-25.
//  Copyright © 2019 Arjun Dureja. All rights reserved.
//

import UIKit

struct WebsiteDescription: Decodable {
    let products: [Products]
}
struct Products: Decodable {
    let images: [Images]
}
struct Images: Decodable {
    let src: String
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        let url = "https://shopicruit.myshopify.com/admin/products.json?page=1&access_token=c32313df0d0ef512ca64d5b336a0d7c6"
        guard let urlObj = URL(string: url) else {return}
        
        URLSession.shared.dataTask(with: urlObj) {(data, response, error) in
            guard let data = data else { return }
        
            do {
                let websiteDescription = try JSONDecoder().decode(WebsiteDescription.self, from: data)
                for items in websiteDescription.products {
                    print(items.images[0].src)
                }
            } catch let jsonErr {
                print(jsonErr)
            }
        }.resume()
    }


}


