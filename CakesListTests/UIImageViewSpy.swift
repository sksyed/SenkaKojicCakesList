//
//  UIImageViewSpy.swift
//  CakesList
//
//  Created by Senka Kojic on 21/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

@testable import CakesList

class UIImageViewSpy: UIImageView {
    
    var imageFromUrlStringCalled = false
    
    var urlString = ""

    override func imageFromUrlString(urlString: String, session: URLSession) {
        
        self.imageFromUrlStringCalled = true
        
        self.urlString = urlString
    }
}
