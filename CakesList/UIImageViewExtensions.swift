//
//  UIImageViewExtensions.swift
//  CakesList
//
//  Created by Senka Kojic on 20/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

let imageCache = NSCache<NSString, AnyObject>()

extension UIImageView {
    
    func imageFromUrlString(urlString: String, session: URLSession) {
        
        guard let url = URL(string: urlString) else {
            
            return
        }
        
        self.image = nil
        
        let key = urlString as NSString
        
        self.setImageFromCache(forKey: key)
        
        self.getImageFromServer(withUrl: url, key: key, session: session)
    }
    
    private func setImageFromCache(forKey key: NSString) {
        
        if let cachedImage = imageCache.object(forKey: key) as? UIImage {
            
            self.image = cachedImage
            
            return
        }
    }
    
    private func getImageFromServer(withUrl url: URL, key: NSString, session: URLSession) {
        
        session.dataTask(with: url) {(data, response, error) in
            
            if error != nil, data == nil {
                
                return
            }
            
            DispatchQueue.main.async{ [weak self] in
                
                if let image = UIImage(data: data!) {
                    
                    imageCache.setObject(image, forKey: key)
                    
                    self?.image = image
                }
            }
            }.resume()
    }
}
