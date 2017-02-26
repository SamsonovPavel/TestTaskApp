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
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
    }

    @IBAction func tapOnEdit(_ sender: UIButton) {
        let editVC = EditController.create() as! EditController
        editVC.delegate = self
        navigationController?.pushViewController(editVC, animated: true)
    }
}

// MARK:- UITableViewDataSource
extension MainController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case rows.firstNameRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: firstNameCellReuseIdentifier,
                                                     for: indexPath) as! FirstNameCell
            cell.textView.isEditable = false
            cell.textView.isSelectable = false
            
            let string = userDefault.value(forKey: firstNameKey) as? String
            
            if let text = string {
                cell.textView.text = text
            } else {
                cell.textView.text = firstName
            }
            
            return cell
            
        case rows.lastNameRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: lastNameCellReuseIdentifier,
                                                     for: indexPath) as! LastNameCell
            cell.textView.isEditable = false
            cell.textView.isSelectable = false
            
            let string = userDefault.value(forKey: lastNameKey) as? String
            
            if let text = string {
                cell.textView.text = text
            } else {
                cell.textView.text = lastName
            }
            
            return cell
            
        case rows.patronymicRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: patronymicCellReuseIdentifier,
                                                     for: indexPath) as! PatronymicCell
            cell.textView.isEditable = false
            cell.textView.isSelectable = false
            
            let string = userDefault.value(forKey: patronymicKey) as? String
            
            if let text = string {
                cell.textView.text = text
            } else {
                cell.textView.text = patronymic
            }
            
            return cell
            
        case rows.birthdayRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: birthdayCellReuseIdentifier,
                                                     for: indexPath) as! BirthdayCell
            let string = userDefault.value(forKey: birthdayKey) as? String
            
            if let text = string {
                cell.birthdayLabel.text = text
            } else {
                cell.birthdayLabel.text = birthday
            }
            return cell
            
        case rows.genderRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: genderCellReuseIdentifier,
                                                     for: indexPath) as! GenderCell
            let string = userDefault.value(forKey: genderKey) as? String
            
            if let text = string {
                cell.genderLabel.text = text
            } else {
                cell.genderLabel.text = gender
            }
            return cell
            
        default: break
        }
        return UITableViewCell()
    }
}

extension MainController: EditControllerDelegate {
    func updateUI() {
        tableView.reloadData()
    }
}










