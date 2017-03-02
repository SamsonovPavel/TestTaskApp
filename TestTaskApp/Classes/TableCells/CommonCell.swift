//
//  CommonCell.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 01.03.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

class CommonCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleTextLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
