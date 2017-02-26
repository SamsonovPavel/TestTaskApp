//
//  LastNameCell.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 23.02.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

class LastNameCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
