//
//  MainController.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 23.02.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

//fileprivate let userDefault = UserDefaults.standard

class MainController: ParentClass {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.allowsSelection = false
    }

    @IBAction func tapOnEdit(_ sender: UIButton) {
        let editVC = EditController.create()
        navigationController?.pushViewController(editVC, animated: true)
    }
}

// MARK:- UITableViewDataSource
extension MainController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case rows.firstNameRow:
            cell = tableView.dequeueReusableCell(withIdentifier: firstNameCellReuseIdentifier, for: indexPath) as! FirstNameCell
            
        case rows.lastNameRow:
            cell = tableView.dequeueReusableCell(withIdentifier: lastNameCellReuseIdentifier, for: indexPath) as! LastNameCell
            
        case rows.patronymicRow:
            cell = tableView.dequeueReusableCell(withIdentifier: patronymicCellReuseIdentifier, for: indexPath) as! PatronymicCell
            
        case rows.birthdayRow:
            cell = tableView.dequeueReusableCell(withIdentifier: birthdayCellReuseIdentifier, for: indexPath) as! BirthdayCell
            
        case rows.genderRow:
            cell = tableView.dequeueReusableCell(withIdentifier: genderCellReuseIdentifier, for: indexPath) as! GenderCell
            
        default: break
        }
        return cell
    }
}
























































