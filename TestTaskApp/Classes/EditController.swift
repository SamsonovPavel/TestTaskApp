//
//  EditController.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 23.02.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

class EditController: ParentClass {
    var picker : UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.title = "Редактирование"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveContent))
    }
}

// MARK:- UITableViewDataSource
extension EditController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        switch indexPath.row {
        case rows.firstNameRow:
            cell = tableView.dequeueReusableCell(withIdentifier: firstNameCellReuseIdentifier, for: indexPath) as! FirstNameCell
            configureFirstNameCell(cell: cell as! FirstNameCell, indexPath: indexPath)
            
        case rows.lastNameRow:
            cell = tableView.dequeueReusableCell(withIdentifier: lastNameCellReuseIdentifier, for: indexPath) as! LastNameCell
            configureLastNameCell(cell: cell as! LastNameCell, indexPath: indexPath)
            
        case rows.patronymicRow:
            cell = tableView.dequeueReusableCell(withIdentifier: patronymicCellReuseIdentifier, for: indexPath) as! PatronymicCell
            configurePatronymicCell(cell: cell as! PatronymicCell, indexPath: indexPath)
            
        case rows.birthdayRow:
            cell = tableView.dequeueReusableCell(withIdentifier: birthdayCellReuseIdentifier, for: indexPath) as! BirthdayCell
            configureBirthdayCell(cell: cell as! BirthdayCell, indexPath: indexPath)
            
        case rows.genderRow:
            cell = tableView.dequeueReusableCell(withIdentifier: genderCellReuseIdentifier, for: indexPath) as! GenderCell
            configureGenderCell(cell: cell as! GenderCell, indexPath: indexPath)
            
        default: break
        }
        return cell
    }
}

extension EditController {
    func configureFirstNameCell(cell: FirstNameCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        
        //        let string = userDefault.value(forKey: firstNameKey) as? String
        //
        //        if let text = string {
        //            cell.firstName.text = text
        //        } else {
        //            cell.firstName.text = firstName
        //        }
    }
    
    func configureLastNameCell(cell: LastNameCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        
        //        let string = userDefault.value(forKey: lastNameKey) as? String
        //
        //        if let text = string {
        //            cell.lastNameLabel.text = text
        //        } else {
        //            cell.lastNameLabel.text = lastName
        //        }
    }
    
    func configurePatronymicCell(cell: PatronymicCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        
        //        let string = userDefault.value(forKey: patronymicKey) as? String
        //
        //        if let text = string {
        //            cell.patronymicLabel.text = text
        //        } else {
        //            cell.patronymicLabel.text = patronymic
        //        }
    }
    
    func configureBirthdayCell(cell: BirthdayCell, indexPath: IndexPath) {
        //        let string = userDefault.value(forKey: birthdayKey) as? String
        //
        //        if let text = string {
        //            cell.birthdayLabel.text = text
        //        } else {
        //            cell.birthdayLabel.text = birhday
        //        }
    }
    
    func configureGenderCell(cell: GenderCell, indexPath: IndexPath) {
        //        let string = userDefault.value(forKey: genderKey) as? String
        //        
        //        if let text = string {
        //            cell.genderLabel.text = text
        //        } else {
        //            cell.genderLabel.text = gender
        //        }
    }
}

extension EditController {
    func saveContent() {
        print("AAA")
    }
}

extension EditController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.contentOffset = currentOffset
    }
}

extension EditController: ViewControllerProtocol {
    static func storyBoardName() -> String {
        return "Main"
    }
}















