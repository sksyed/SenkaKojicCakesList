//
//  ViewController.swift
//  CakesList
//
//  Created by Senka Kojic on 19/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

class CakesViewController: UIViewController {
    
    @IBOutlet weak var cakesTableView: UITableView!
    
    fileprivate let cellIdentifier = "CakeTableViewCell"
    fileprivate var viewModel: CakesViewModelProtocol?
    fileprivate var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel = CakesViewModel()
        
        self.viewModel?.delegate = self
        
        self.configureRefreshControl()
        
        self.registerNibs()
        
        self.getCakeData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.refreshTableView()
    }
    
    private func registerNibs() {
        
        let cakeCell = UINib(nibName: String(describing: CakeTableViewCell.self), bundle: Bundle.main)
        
        self.cakesTableView.register(cakeCell, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    fileprivate func refreshTableView() {
        
        self.cakesTableView.reloadData()
    }
    
    @objc private func getCakeData() {
        
        self.refreshControl.beginRefreshing()
        
        self.viewModel?.getData()
    }
    
    private func configureRefreshControl() {
        
        let selector = #selector(CakesViewController.getCakeData)
        
        self.refreshControl.addTarget(self, action: selector, for: UIControlEvents.valueChanged)
        
        self.cakesTableView.addSubview(self.refreshControl)
    }
}

extension CakesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel?.cakes.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        if let cakeCell = cell as? CakeTableViewCell {
            
            let cake = self.viewModel?.cakes[indexPath.row]
            
            cakeCell.cakeTitle.text = cake!.title
            
            cakeCell.cakeDescription.text = cake!.cakeDescription
            
            cell = cakeCell
        }
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
}

extension CakesViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell:UITableViewCell, forRowAt indexPath:IndexPath) {
        
        let imageURL = self.viewModel?.cakes[indexPath.row].imageURL
        
        let updatingCell = cell as! CakeTableViewCell
        
        updatingCell.updateCellImage(withUrl: imageURL!)
    }
}

extension CakesViewController: CakesViewModelDelegate {
    
    func reloadData() {
        
        self.refreshControl.endRefreshing()
        
        self.refreshTableView()
    }
}

