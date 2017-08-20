//
//  CakeTableViewCell.swift
//  CakesList
//
//  Created by Senka Kojic on 19/08/2017.
//  Copyright © 2017 Senka Kojic. All rights reserved.
//

import UIKit

class CakeTableViewCell: UITableViewCell {
    
    @IBOutlet weak var cakeImageView: UIImageView!
    
    @IBOutlet weak var cakeTitle: UILabel!

    @IBOutlet weak var cakeDescription: UILabel!
    
    var urlSession = URLSession.shared
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateCellImage(withUrl: URL) {
        
        self.cakeImageView.imageFromUrl(url: withUrl)
    }
}
