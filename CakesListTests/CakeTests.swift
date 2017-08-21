//
//  CakeTests.swift
//  CakesList
//
//  Created by Senka Kojic on 21/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import XCTest

@testable import CakesList

class CakeTests: XCTestCase {
    
    
    func testInitWithDictionarySetsCakeAsExpected() {
        
        let cakeDictionary = ["title": "my title", "desc": "my description", "image": "someUrl"]
        
        let cake = Cake(withDictionary: cakeDictionary)
        
        XCTAssertEqual(cake.title, "my title", "Title was not set correctly")
        
        XCTAssertEqual(cake.cakeDescription, "my description", "Description was not set correctly")
        
        XCTAssertEqual(cake.imageUrlString, "someUrl", "Url string was not set correctly")
    }
    
}
