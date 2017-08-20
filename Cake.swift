//
//  Cake.swift
//  CakesList
//
//  Created by Senka Kojic on 20/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

class Cake: NSObject {
    
    var title = ""
    var cakeDescription = ""
    var imageURL: URL?
        
    convenience init(withTitle title: String, cakeDescription: String, imageURL: URL) {
        self.init()
        self.title = title
        self.cakeDescription = cakeDescription
        self.imageURL = imageURL
    }
    
    convenience init(withDictionary dictionary: [AnyHashable: Any]) {
        
        let title = dictionary.stringValueForKey("title")
        let cakeDescription = dictionary.stringValueForKey("desc")
        let imageURL = dictionary.urlForKey("image")
        
        self.init(withTitle: title, cakeDescription: cakeDescription, imageURL: imageURL)
    }
    
    class func cakeFromJsonArray(jsonArray: [[AnyHashable: Any]]) -> [Cake] {
        
        var cakes = [Cake]()
        
        for dictionary in jsonArray {
            
            cakes.append(Cake(withDictionary: dictionary))
        }
        
        return cakes
    }
}
