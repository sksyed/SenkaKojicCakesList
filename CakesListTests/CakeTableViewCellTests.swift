//
//  CakeTableViewCellTests.swift
//  CakesList
//
//  Created by Senka Kojic on 21/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import XCTest

@testable import CakesList

class CakeTableViewCellTests: XCTestCase {
    
    private var cakeImageView = UIImageViewSpy()
    
    override func setUp() {
        super.setUp()
        
        self.cakeImageView = UIImageViewSpy()
    }
    
    func testUpdateCellImageCallsImageFromUrlString() {
        
        let cell = CakeTableViewCell()
        
        cell.cakeImageView = self.cakeImageView
        
        cell.updateCellImage(withUrlFromString: "My string")
        
        XCTAssertTrue(self.cakeImageView.imageFromUrlStringCalled, "Image from url string should have been called")
        
        XCTAssertEqual(self.cakeImageView.urlString, "My string", "Url string is not correct")
    }
}
