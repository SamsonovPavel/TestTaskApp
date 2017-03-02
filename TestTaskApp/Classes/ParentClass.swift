//
//  ParentClass.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 23.02.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

let fullNameCellReuseIdentifier   = "FullNameCell"
let commonCellReuseIdentifier     = "CommonCell"
let birthdayCellReuseIdentifier   = "BirthdayCell"
let genderCellReuseIdentifier     = "GenderCell"

class ParentClass: UITableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        let fullNameNib = UINib(nibName: "FullNameCell", bundle: nil)
        tableView.register(fullNameNib, forCellReuseIdentifier: fullNameCellReuseIdentifier)
        
        let commonNib = UINib(nibName: "CommonCell", bundle: nil)
        tableView.register(commonNib, forCellReuseIdentifier: commonCellReuseIdentifier)
        
        let birthdayNib = UINib(nibName: "BirthdayCell", bundle: nil)
        tableView.register(birthdayNib, forCellReuseIdentifier: birthdayCellReuseIdentifier)
        
        let genderNib = UINib(nibName: "GenderCell", bundle: nil)
        tableView.register(genderNib, forCellReuseIdentifier: genderCellReuseIdentifier)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK:- UITableViewDelegate
extension ParentClass {
    override func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1.0
    }
}

extension ParentClass {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
}
