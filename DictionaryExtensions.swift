//
//  DictionaryExtensions.swift
//  CakesList
//
//  Created by Senka Kojic on 20/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

extension Dictionary {
    
    func stringValueForKey(_ key: String) -> String {
        
        if let dictionaryKey = key as? Key {
            
            if let value = self[dictionaryKey] {
                
                if String(describing: value) == "nil" {
                    
                    return ""
                }
                
                if let stringValue = value as? NSString {
                    
                    return stringValue as String
                }
            }
        }
        
        return ""
    }
    
    func urlForKey(_ key: String) -> URL {
        
        let urlString = self.stringValueForKey(key)
        
        return URL(string: urlString)!
    }
}
