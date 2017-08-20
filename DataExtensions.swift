//
//  DataExtensions.swift
//  CakesList
//
//  Created by Senka Kojic on 20/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

extension Data {
    
    func serializeToDictionaryArray() -> [[AnyHashable: Any]]? {
        
        do {
            
            guard let object = try JSONSerialization.jsonObject(with: self, options: JSONSerialization.ReadingOptions(rawValue: 0)) as? [[AnyHashable: Any]] else {
                
                return nil
            }
            
            return object
            
        } catch {
            
            return nil
        }
    }
}
