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
    var imageUrlString = ""
        
    convenience init(withTitle title: String, cakeDescription: String, imageUrlString: String) {
        self.init()
        self.title = title
        self.cakeDescription = cakeDescription
        self.imageUrlString = imageUrlString
    }
    
    convenience init(withDictionary dictionary: [AnyHashable: Any]) {
        
        let title = dictionary.stringValueForKey("title")
        let cakeDescription = dictionary.stringValueForKey("desc")
        let imageUrlString = dictionary.stringValueForKey("image")
        
        self.init(withTitle: title, cakeDescription: cakeDescription, imageUrlString: imageUrlString)
    }
}
