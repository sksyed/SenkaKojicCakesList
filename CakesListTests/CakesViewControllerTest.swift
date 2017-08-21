//
//  CakesViewControllerTest.swift
//  CakesList
//
//  Created by Senka Kojic on 20/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import XCTest

@testable import CakesList

class CakesViewModelSpy: CakesViewModelProtocol {
    
    var getDataCalled = false
    
    var cakes: [Cake] = [Cake]()
    
    var delegate: CakesViewModelDelegate?
    
    func getData() {
        
        self.getDataCalled = true
    }
}

class CakesViewControllerTest: XCTestCase {
    
    private var viewModel = CakesViewModelSpy()
    
    fileprivate var cakesTableView = UITableViewSpy()
    
    fileprivate var reloadDataCalled = false
    
    private var cakeTitle = UILabel()
    private var cakeDescription = UILabel()
    private var cakeImageView = UIImageView()
    
    override func setUp() {
        
        super.setUp()
        self.viewModel = CakesViewModelSpy()
        self.viewModel.cakes = [Cake()]
        self.cakesTableView = UITableViewSpy()
        self.viewModel.delegate = self
        self.reloadDataCalled = false
    }
    
    private func buildViewController() -> CakesViewController {
        
        let viewController = CakesViewController()
        
        viewController.cakesTableView = self.cakesTableView
        viewController.cakesTableView.delegate = viewController
        viewController.cakesTableView.dataSource = viewController
        
        viewController.viewModel = self.viewModel
        
        return viewController
    }
    
    func testViewDidLoadCallsGetCakeData() {
        
        let viewController = self.buildViewController()
        
        viewController.viewDidLoad()
        
        XCTAssertTrue(self.viewModel.getDataCalled, "Get cake data should have been called")
    }
    
    func testNumberOfRowsInSectionReturns1WhenCakesArrayHasOneElement() {
        
        let viewController = self.buildViewController()
        
        viewController.viewDidLoad()
        
        let numberOfRows = viewController.tableView(self.cakesTableView, numberOfRowsInSection: 1)
        
        XCTAssertEqual(numberOfRows, 1, "Number of rows should be 1")
    }
    
    func testNumberOfRowsInSectionReturns2WhenCakesArrayHasTwoElements() {
        
        self.viewModel.cakes = [Cake(), Cake()]
        
        let viewController = self.buildViewController()
        
        viewController.viewDidLoad()
        
        let numberOfRows = viewController.tableView(self.cakesTableView, numberOfRowsInSection: 1)
        
        XCTAssertEqual(numberOfRows, 2, "Number of rows should be 2")
    }
    
    private func buildCellToReturn() -> CakeTableViewCell {
        
        let cell = CakeTableViewCell()
        
        cell.cakeTitle = self.cakeTitle
        cell.cakeDescription = self.cakeDescription
        cell.cakeImageView = self.cakeImageView
        
        return cell
    }
    
    func testCellForRowAtIndexPath00SetsCellAsExpected() {
        
        let cake = Cake(withTitle: "title", cakeDescription: "description", imageUrlString: "")
        
        self.viewModel.cakes = [cake]
        
        self.cakesTableView.cellToReturn = self.buildCellToReturn()
        
        let viewController = self.buildViewController()
        
        viewController.viewDidLoad()
        
        let cell = viewController.tableView(self.cakesTableView, cellForRowAt: IndexPath(row: 0, section: 0)) as? CakeTableViewCell
        
        XCTAssertEqual(cell?.cakeTitle.text, "title", "The cell title is not correct")
        
        XCTAssertEqual(cell?.cakeDescription.text, "description", "The cell description is not correct")
    }
    
    func testNumberOfSectionsReturns1() {
        
        let viewController = self.buildViewController()
        
        viewController.viewDidLoad()
        
        let numberOfSections = viewController.numberOfSections(in: self.cakesTableView)
        
        XCTAssertEqual(numberOfSections, 1, "Number of sections is not correct")
    }
    
    func testDidSelectRowAtIndextPath00DeselectsTheCell() {
        
        let viewController = self.buildViewController()
        
        viewController.viewDidLoad()
        
        viewController.tableView(self.cakesTableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(self.cakesTableView.deselectRowAtIndexPathCalled, "Deselect should have been called")
    }
}

extension CakesViewControllerTest: CakesViewModelDelegate {
    
    func reloadData() {
        
        self.reloadDataCalled = true
    }
}
