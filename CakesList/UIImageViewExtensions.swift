//
//  UIImageViewExtensions.swift
//  CakesList
//
//  Created by Senka Kojic on 20/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

extension UIImageView {

    func imageFromUrl(url: URL) {
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                return
            }
            
            DispatchQueue.main.async(execute: { 
                let image = UIImage(data: data!)
                self.image = image
            })
        }.resume()
    }
}
