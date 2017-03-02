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
        case rows.firstNameRow, rows.lastNameRow, rows.patronymicRow:
            let cell = tableView.dequeueReusableCell(withIdentifier: fullNameCellReuseIdentifier,
                                                     for: indexPath) as! FullNameCell
            cell.textView.isEditable = false
            cell.textView.isSelectable = false
            cell.title.text = dataArray[indexPath.row]
            
            if indexPath.row == rows.firstNameRow {
                cell.textView.text = userDefault.value(forKey: firstNameKey) as? String
            } else if indexPath.row == rows.lastNameRow {
                cell.textView.text = userDefault.value(forKey: lastNameKey) as? String
            } else if indexPath.row == rows.patronymicRow {
                cell.textView.text = userDefault.value(forKey: patronymicKey) as? String
            }
            return cell
            
        case rows.birthdayRow, rows.genderRow - 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: commonCellReuseIdentifier,
                                                     for: indexPath) as! CommonCell
            cell.titleLabel.text = dataArray[indexPath.row]
            
            if indexPath.row == rows.birthdayRow {
                cell.titleTextLabel.text = userDefault.value(forKey: birthdayKey) as? String
            } else if indexPath.row == rows.genderRow - 1 {
                cell.titleTextLabel.text = userDefault.value(forKey: genderKey) as? String
            }
            return cell
        default: break
        }
        return UITableViewCell()
    }
}

// MARK:- EditControllerDelegate
extension MainController: EditControllerDelegate {
    func updateUI() {
        tableView.reloadData()
    }
}
