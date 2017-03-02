//
//  EditController.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 23.02.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import UIKit

protocol EditControllerDelegate {
    func updateUI()
}

class EditController: ParentClass {
    var picker: UIPickerView?
    var datePicker: UIDatePicker?
    
    let pickerArr = ["Мужской" ,"Женский", "Не указан"]
    
    var firstNameTextView  = UITextView()
    var lastNameTextView   = UITextView()
    var patronymicTextView = UITextView()
    
    var firstNameText  = ""
    var lastNameText   = ""
    var patronymicText = ""
    
    var birthdayCell: CommonCell?
    var birthdayText: String?
    var genderText: String?
    
    var tap: UITapGestureRecognizer?
    
    var delegate: EditControllerDelegate?
    
    var isChanged = false
    
    var datePickerIndexPath: IndexPath?
    var pickerViewIndexPath: IndexPath?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50.0
        tableView.rowHeight = UITableViewAutomaticDimension
        
        navigationItem.title = "Редактирование"
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Сохранить",
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveContent))
        
        tap = UITapGestureRecognizer(target: self, action: #selector(textViewResponders))
        
        self.navigationItem.hidesBackButton = true
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: self, action: #selector(backButton(sender:)))
        self.navigationItem.leftBarButtonItem = backButton
    }
}

// MARK:- UITableViewDataSource
extension EditController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isExistIndexPathDatePicker || isExistIndexPathPickerView {
            return dataArray.count + 1
        }
        return dataArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = UITableViewCell()
        
        if indexPath.row == rows.firstNameRow || indexPath.row == rows.lastNameRow || indexPath.row == rows.patronymicRow {
            cell = tableView.dequeueReusableCell(withIdentifier: fullNameCellReuseIdentifier, for: indexPath) as! FullNameCell
            (cell as! FullNameCell).title.text = dataArray[indexPath.row]
            
            if indexPath.row == rows.firstNameRow {
                configureFirstNameCell(cell: cell as! FullNameCell, indexPath: indexPath)
            } else if indexPath.row == rows.lastNameRow {
                configureLastNameCell(cell: cell as! FullNameCell, indexPath: indexPath)
            } else if indexPath.row == rows.patronymicRow {
                configurePatronymicCell(cell: cell as! FullNameCell, indexPath: indexPath)
            }
        } else if indexPath.row == rows.birthdayRow {
            cell = tableView.dequeueReusableCell(withIdentifier: commonCellReuseIdentifier, for: indexPath) as! CommonCell
            configureBirthdayCell(cell: cell as! CommonCell, indexPath: indexPath)
        } else if indexPath.row == rows.genderRow - 1 {
            cell = tableView.dequeueReusableCell(withIdentifier: commonCellReuseIdentifier, for: indexPath) as! CommonCell
            configureGenderCell(cell: cell as! CommonCell, indexPath: indexPath)
        } else if indexPath.row == rows.genderRow {
            cell = tableView.dequeueReusableCell(withIdentifier: genderCellReuseIdentifier, for: indexPath) as! GenderCell
            (cell as! GenderCell).pickerView.delegate = self
        }
        
        if isExistIndexPathDatePicker {
            if indexPath.row == rows.birthdayDatePickerRow {
                cell = tableView.dequeueReusableCell(withIdentifier: birthdayCellReuseIdentifier, for: indexPath) as! BirthdayCell
                datePicker = (cell as! BirthdayCell).datePicker
                datePicker?.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
            } else if indexPath.row == rows.genderRow {
                cell = tableView.dequeueReusableCell(withIdentifier: commonCellReuseIdentifier, for: indexPath) as! CommonCell
                configureGenderCell(cell: cell as! CommonCell, indexPath: indexPath)
            }
        }
        return cell
    }
}

// MARK:- UITableViewDelegate
extension EditController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == rows.birthdayRow {
            if isExistIndexPathPickerView {
                let index = IndexPath(row: indexPath.row + 1, section: 0)
                togglePickerViewForSelectedIndexPath(indexPath: index)
            }
            toggleDatePickerForSelectedIndexPath(indexPath: indexPath)
        } else if isExistIndexPathDatePicker {
            if indexPath.row == rows.genderRow {
                toggleDatePickerForSelectedIndexPath(indexPath: indexPath)
                togglePickerViewForSelectedIndexPath(indexPath: indexPath)
            }
        } else {
            togglePickerViewForSelectedIndexPath(indexPath: indexPath)
        }
        tableView.reloadData()
    }
}

// MARK:- Additional handlers
extension EditController {
    func handleDatePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthdayText = formatter.string(from: sender.date)
        
        if birthdayText != userDefault.value(forKey: birthdayKey) as? String {
            isChanged = true
        } else {
            isChanged = false
        }
        tableView.reloadData()
    }
    
    func backButton(sender: UIBarButtonItem) {
        if isChanged {
            let title = "Предупреждение"
            let message = "Данные были изменены. Вы желаете сохранить изменения, в противном случае внесенные правки будут отменены."
            let titleSave = "Сохранить"
            let titleSkip = "Пропустить"
            
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            
            let alertSave = UIAlertAction(title: titleSave, style: .default, handler: { [weak self] (action) in
                guard let sself = self else { return }
                sself.saveContent()
                _ = sself.navigationController?.popViewController(animated: true)
            })
            
            let alertSkip = UIAlertAction(title: titleSkip, style: .default, handler: { [weak self] (action) in
                guard let sself = self else { return }
                _ = sself.navigationController?.popViewController(animated: true)
            })
            
            alertController.addAction(alertSave)
            alertController.addAction(alertSkip)
            self.present(alertController, animated: true, completion: nil)
            isChanged = false
        } else {
            _ = navigationController?.popViewController(animated: true)
        }
        textViewResponders()
    }
    
    fileprivate func toggleDatePickerForSelectedIndexPath(indexPath: IndexPath) {
        tableView.beginUpdates()
        var indexRow = indexPath.row
        if !isExistIndexPathDatePicker {
            indexRow += 1
        } else {
            indexRow -= 1
        }
        let index = [IndexPath(row: indexRow, section: 0)]
        
        if (datePickerIndexPath != nil) {
            tableView.deleteRows(at: index, with: .fade)
            datePickerIndexPath = nil
        } else {
            tableView.insertRows(at: index, with: .fade)
            datePickerIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
        }
        tableView.endUpdates()
    }
    fileprivate func togglePickerViewForSelectedIndexPath(indexPath: IndexPath) {
        tableView.beginUpdates()
        var indexRow = indexPath.row
        if isExistIndexPathDatePicker {
            indexRow += 1
        }
        let index = [IndexPath(row: indexRow, section: 0)]
        
        if (pickerViewIndexPath != nil) {
            tableView.deleteRows(at: index, with: .fade)
            pickerViewIndexPath = nil
        } else {
            tableView.insertRows(at: index, with: .fade)
            pickerViewIndexPath = IndexPath(row: indexPath.row + 1, section: 0)
        }
        tableView.endUpdates()
    }
    
    fileprivate var isExistIndexPathDatePicker: Bool {
        return (datePickerIndexPath != nil)
    }
    fileprivate var isExistIndexPathPickerView: Bool {
        return (pickerViewIndexPath != nil)
    }
}

// MARK:- ConfigureCell
extension EditController {
    func configureFirstNameCell(cell: FullNameCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        firstNameTextView = cell.textView
        cell.textView.tag = 1
        
        if firstNameText != "" {
            cell.textView.text = firstNameText
        } else {
            cell.textView.text = userDefault.value(forKey: firstNameKey) as? String
        }
    }

    func configureLastNameCell(cell: FullNameCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        lastNameTextView = cell.textView
        cell.textView.tag = 2
        
        if lastNameText != "" {
            cell.textView.text = lastNameText
        } else {
            cell.textView.text = userDefault.value(forKey: lastNameKey) as? String
        }
    }
    
    func configurePatronymicCell(cell: FullNameCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        patronymicTextView = cell.textView
        cell.textView.tag = 3
        
        if patronymicText != "" {
            cell.textView.text = patronymicText
        } else {
            cell.textView.text = userDefault.value(forKey: patronymicKey) as? String
        }
    }
    
    func configureBirthdayCell(cell: CommonCell, indexPath: IndexPath) {
        birthdayCell = cell
        cell.titleLabel.text = dataArray[indexPath.row]
        
        if let text = birthdayText {
            cell.titleTextLabel.text = text
        } else {
            cell.titleTextLabel.text = userDefault.value(forKey: birthdayKey) as? String
        }
    }
    
    func configureGenderCell(cell: CommonCell, indexPath: IndexPath) {
        var index = indexPath.row
        if isExistIndexPathDatePicker {
            index -= 1
        }
        cell.titleLabel.text = dataArray[index]
        
        if let text = genderText {
            cell.titleTextLabel.text = text
        } else {
            cell.titleTextLabel.text = userDefault.value(forKey: genderKey) as? String
        }
    }
}

// MARK:- UIPickerViewDelegate, UIPickerViewDataSource
extension EditController: UIPickerViewDelegate, UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 3
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerArr[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        genderText = pickerArr[row]
        
        if genderText != userDefault.value(forKey: genderKey) as? String {
            isChanged = true
        } else {
            isChanged = false
        }
        tableView.reloadData()
    }
}

// MARK:- UITextViewDelegate
extension EditController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        view.addGestureRecognizer(tap!)
        return true
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        tableView.contentOffset = currentOffset
        
        let firstName = userDefault.value(forKey: firstNameKey) ?? "Error"
        let lastName = userDefault.value(forKey: lastNameKey) ?? "Error"
        let patronymic = userDefault.value(forKey: patronymicKey) ?? "Error"
        
        switch textView.text {
        case firstName as! String: isChanged = false
        case lastName as! String: isChanged = false
        case patronymic as! String: isChanged = false
        default: isChanged = true
        }
        
        switch textView.tag {
        case 1: firstNameText = textView.text
        case 2: lastNameText = textView.text
        case 3: patronymicText = textView.text
        default: break
        }
    }
}

// MARK:- ViewControllerProtocol
extension EditController: ViewControllerProtocol {
    static func storyBoardName() -> String {
        return "Main"
    }
}




















