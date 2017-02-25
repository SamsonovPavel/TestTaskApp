//
//  MainController.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 23.02.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

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
        
        switch indexPath.row {
        case rows.firstNameRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: firstNameCellReuseIdentifier, for: indexPath) as! FirstNameCell
            cell.textView.isEditable = false
            return cell
            
        case rows.lastNameRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: lastNameCellReuseIdentifier, for: indexPath) as! LastNameCell
            return cell
            
        case rows.patronymicRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: patronymicCellReuseIdentifier, for: indexPath) as! PatronymicCell
            return cell
            
        case rows.birthdayRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: birthdayCellReuseIdentifier, for: indexPath) as! BirthdayCell
            return cell
            
        case rows.genderRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: genderCellReuseIdentifier, for: indexPath) as! GenderCell
            return cell
            
        default: break
        }
        return UITableViewCell()
    }
}










