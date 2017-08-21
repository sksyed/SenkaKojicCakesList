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
    
    var viewModel: CakesViewModelProtocol = CakesViewModel()
    
    fileprivate let cellIdentifier = "CakeTableViewCell"
    fileprivate var refreshControl = UIRefreshControl()
    
    //MARK: - viewDidLoad()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewModel.delegate = self
        
        self.configureRefreshControl()
        
        self.registerNibs()
        
        self.getCakeData()
    }
    
    private func configureRefreshControl() {
        
        let selector = #selector(CakesViewController.refreshCakeData)
        
        self.refreshControl.addTarget(self, action: selector, for: UIControlEvents.valueChanged)
        
        self.cakesTableView.addSubview(self.refreshControl)
    }
    
    private func registerNibs() {
        
        let cakeCell = UINib(nibName: String(describing: CakeTableViewCell.self), bundle: Bundle.main)
        
        self.cakesTableView.register(cakeCell, forCellReuseIdentifier: self.cellIdentifier)
    }
    
    private func getCakeData() {
        
        self.refreshControl.beginRefreshing()
        
        self.viewModel.getData()
    }
    
    @objc private func refreshCakeData() {
        
        self.refreshTableView()
        
        self.getCakeData()
    }
    
    fileprivate func refreshTableView() {
        
        self.cakesTableView.reloadData()
    }
    
    //MARK: - viewWillAppear
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        self.refreshTableView()
    }
}

extension CakesViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.viewModel.cakes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifier, for: indexPath)
        
        if let cakeCell = cell as? CakeTableViewCell {
            
            let cake = self.viewModel.cakes[indexPath.row]
            
            cakeCell.cakeTitle.text = cake.title
            
            cakeCell.cakeDescription.text = cake.cakeDescription
            
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
        
        let imageUrlString = self.viewModel.cakes[indexPath.row].imageUrlString
        
        if let updatingCell = cell as? CakeTableViewCell {
            
            updatingCell.updateCellImage(withUrlFromString: imageUrlString)
            
        }
    }
}

extension CakesViewController: CakesViewModelDelegate {
    
    func reloadData() {
        
        self.refreshControl.endRefreshing()
        
        self.refreshTableView()
    }
}

