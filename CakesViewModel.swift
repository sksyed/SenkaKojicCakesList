//
//  CakesViewModel.swift
//  CakesList
//
//  Created by Senka Kojic on 19/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

protocol CakesViewModelProtocol {
    
    func getData()
    
    var cakes: [Cake] { get set }
    
    var delegate: CakesViewModelDelegate? { get set }
}

protocol CakesViewModelDelegate {
    
    func reloadData()
}

import UIKit

class CakesViewModel: CakesViewModelProtocol {
    
    let urlString = "https://gist.githubusercontent.com/hart88/198f29ec5114a3ec3460/raw/8dd19a88f9b8d24c23d9960f3300d0c917a4f07c/cake.json"
    var urlSession = URLSession.shared
    
    var delegate: CakesViewModelDelegate?
    
    var cakes: [Cake] = []
    
    //MARK: - getData()
    
    func getData() {
        
        guard let url = URL(string: self.urlString) else {
            
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            
            if error == nil, let usableData = data {
                
                guard let jsonArray = usableData.serializeToDictionaryArray() else {
                    
                    return
                }
                
                DispatchQueue.main.async { [weak self] in
                    
                    self?.cakes = self?.cakesFromJsonArray(jsonArray: jsonArray) ?? [Cake]()
                    
                    self?.delegate?.reloadData()
                }
            }
        }
        
        task.resume()
    }
    
    private func cakesFromJsonArray(jsonArray: [[AnyHashable: Any]]) -> [Cake] {
        
        var cakes = [Cake]()
        
        for dictionary in jsonArray {
            
            cakes.append(Cake(withDictionary: dictionary))
        }
        
        return cakes
    }
}
