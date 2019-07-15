//
//  TableViewCell.swift
//  Currency
//
//  Created by Alexandr on 7/12/19.
//  Copyright © 2019 Alex Kolinko. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    
    @IBOutlet weak var currency: UILabel!
    @IBOutlet weak var buy: UILabel!
    @IBOutlet weak var sale: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
}
