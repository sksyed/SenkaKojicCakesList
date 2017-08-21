//
//  UITableViewSpy.swift
//  CakesList
//
//  Created by Senka Kojic on 20/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

class UITableViewSpy: UITableView {
    
    var cellToReturn: UITableViewCell?
    var deselectRowAtIndexPathCalled = false
    
    var nibIdentifiers = [String]()
    
    override func deselectRow(at indexPath: IndexPath, animated: Bool) {
        
        self.deselectRowAtIndexPathCalled = true
    }
    
    override func register(_ nib: UINib?, forCellReuseIdentifier identifier: String) {
        
        if !nibIdentifiers.contains(identifier) {
            self.nibIdentifiers.append(identifier)
        }
        
        super.register(nib, forCellReuseIdentifier: identifier)
    }
    
    override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
        
        if self.cellToReturn != nil {
            return self.cellToReturn!
        }
        
        return UITableViewCell()
    }
}
