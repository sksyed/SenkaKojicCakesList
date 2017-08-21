//
//  CakesViewModelTests.swift
//  CakesList
//
//  Created by Senka Kojic on 21/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import XCTest

@testable import CakesList

class CakesViewModelTests: XCTestCase {
    
    fileprivate var expectation: XCTestExpectation?
    
    fileprivate var reloadDataCalled = false
    
    override func setUp() {
        super.setUp()
        
        self.expectation = self.expectation(description: "CakeViewModelTest")
        
        self.reloadDataCalled = false
    }
    
    private func buildViewModel() -> CakesViewModel {
        
        let viewModel = CakesViewModel()
        
        viewModel.delegate = self
        
        viewModel.cakes = [Cake]()
        
        return viewModel
    }
    
    func testGetDataCallsReloadData() {
        
        let viewModel = self.buildViewModel()
        
        viewModel.getData()
        
        self.waitForExpectations(timeout: 150.0, handler: nil)
        
        XCTAssertTrue(self.reloadDataCalled)
        
        XCTAssertNotEqual(viewModel.cakes.count, 0, "Cakes count should have changed from zero")
    }
}

extension CakesViewModelTests: CakesViewModelDelegate {
    
    func reloadData() {
        
        self.reloadDataCalled = true
        self.expectation?.fulfill()
    }
}
