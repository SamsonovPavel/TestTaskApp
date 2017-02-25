//
//  ParentClass.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 23.02.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

let firstNameCellReuseIdentifier  = "FirstNameCell"
let lastNameCellReuseIdentifier   = "LastNameCell"
let patronymicCellReuseIdentifier = "PatronymicCell"
let birthdayCellReuseIdentifier   = "BirthdayCell"
let genderCellReuseIdentifier     = "GenderCell"

class ParentClass: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let firstNameNib = UINib(nibName: "FirstNameCell", bundle: nil)
        tableView.register(firstNameNib, forCellReuseIdentifier: firstNameCellReuseIdentifier)
        
        let lastNameNib = UINib(nibName: "LastNameCell", bundle: nil)
        tableView.register(lastNameNib, forCellReuseIdentifier: lastNameCellReuseIdentifier)
        
        let patronymicNib = UINib(nibName: "PatronymicCell", bundle: nil)
        tableView.register(patronymicNib, forCellReuseIdentifier: patronymicCellReuseIdentifier)
        
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
        return 10.0
    }
}

extension ParentClass {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
}
