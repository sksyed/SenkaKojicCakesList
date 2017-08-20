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
    
    func getData() {
        
        guard let url = URL(string: self.urlString) else {
            
            return
        }
        
        let request = URLRequest(url: url)
        
        let task = self.urlSession.dataTask(with: request) { (data, response, error) in
            if error == nil, let usableData = data {
                
                guard let jsonData = self.getJsonData(data: usableData) else {
                    
                    return
                }
                
                guard let jsonDictionary = self.getJsonDictionary(jsonData) else {
                    
                    return
                }
                DispatchQueue.main.async {
                    
                    self.cakes = Cake.cakeFromJsonArray(jsonArray: jsonDictionary)
                    
                    self.delegate?.reloadData()
                }
            }
        }
        
        task.resume()
        
    }
    
    private func getJsonData(data: Data) -> AnyObject? {
        
        do {
            
            let jsonResult  = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
            
            return jsonResult as AnyObject
            
        } catch {
            
            
        }
        
        return nil
    }
    
    private func getJsonDictionary(_ jsonResult: AnyObject) -> [[AnyHashable: Any]]? {
        
        guard let jsonDictionary = jsonResult as? [[AnyHashable: Any]] else {
            
            return nil
        }
        
        return jsonDictionary
    }
}
