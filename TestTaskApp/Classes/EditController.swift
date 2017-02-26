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
    
    var birthdayCell: BirthdayCell!
    var genderCell: GenderCell!
    
    var tap: UITapGestureRecognizer?
    
    var delegate: EditControllerDelegate?
    
    var isChanged = false
    
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
            birthdayCell = cell as! BirthdayCell
            
        case rows.genderRow:
            cell = tableView.dequeueReusableCell(withIdentifier: genderCellReuseIdentifier, for: indexPath) as! GenderCell
            configureGenderCell(cell: cell as! GenderCell, indexPath: indexPath)
            genderCell = cell as! GenderCell
            
        default: break
        }
        return cell
    }
}

// MARK:- UITableViewDelegate
extension EditController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case rows.birthdayRow:
            textViewResponders()
            
            datePicker = UIDatePicker(frame: CGRect(origin: CGPoint(x: 0, y: self.view.frame.size.height - 300),
                                                    size: CGSize(width: (self.view.frame.size.width), height: 300)))
            datePicker?.datePickerMode = .date
            datePicker?.addTarget(self, action: #selector(handleDatePicker(sender:)), for: UIControlEvents.valueChanged)
            self.view.addSubview(datePicker!)
            
        case rows.genderRow:
            textViewResponders()
            
            picker = UIPickerView(frame: CGRect(origin: CGPoint(x: 0, y: self.view.frame.size.height - 300),
                                                size: CGSize(width: (self.view.frame.size.width), height: 300)))
            picker?.delegate = self
            picker?.dataSource = self
            
            self.view.addSubview(picker!)
            
        default: break
        }
    }
}

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
        genderCell.genderLabel.text = pickerArr[row]
        view.addGestureRecognizer(tap!)
    }
}

extension EditController {
    func handleDatePicker(sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        birthdayCell.birthdayLabel.text = formatter.string(from: sender.date)
        view.addGestureRecognizer(tap!)
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
}

extension EditController {
    func configureFirstNameCell(cell: FirstNameCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        firstNameTextView = cell.textView
        
        let string = userDefault.value(forKey: firstNameKey) as? String
        
        if let text = string {
            cell.textView.text = text
        } else {
            cell.textView.text = firstName
        }

    }
    
    func configureLastNameCell(cell: LastNameCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        lastNameTextView = cell.textView
        
        let string = userDefault.value(forKey: lastNameKey) as? String
        
        if let text = string {
            cell.textView.text = text
        } else {
            cell.textView.text = lastName
        }
    }
    
    func configurePatronymicCell(cell: PatronymicCell, indexPath: IndexPath) {
        cell.textView.delegate = self
        patronymicTextView = cell.textView
        
        let string = userDefault.value(forKey: patronymicKey) as? String
        
        if let text = string {
            cell.textView.text = text
        } else {
            cell.textView.text = patronymic
        }
    }
    
    func configureBirthdayCell(cell: BirthdayCell, indexPath: IndexPath) {
        let string = userDefault.value(forKey: birthdayKey) as? String
        
        if let text = string {
            cell.birthdayLabel.text = text
        } else {
            cell.birthdayLabel.text = birthday
        }
    }
    
    func configureGenderCell(cell: GenderCell, indexPath: IndexPath) {
        let string = userDefault.value(forKey: genderKey) as? String
        
        if let text = string {
            cell.genderLabel.text = text
        } else {
            cell.genderLabel.text = gender
        }

    }
}

extension EditController {
    func saveContent() {
        saveChangeContent()
        delegate?.updateUI()
        isChanged = false
    }
    
    func saveChangeContent() {
        userDefault.set(firstNameTextView.text, forKey: firstNameKey)
        userDefault.set(lastNameTextView.text, forKey: lastNameKey)
        userDefault.set(patronymicTextView.text, forKey: patronymicKey)
        userDefault.set(birthdayCell.birthdayLabel.text, forKey: birthdayKey)
        userDefault.set(genderCell.genderLabel.text, forKey: genderKey)
    }
    
    func textViewResponders() {
        if firstNameTextView.isFirstResponder {
            UIView.animate(withDuration: 0.7, animations: { [weak self] in
                guard let sself = self else { return }
                sself.firstNameTextView.resignFirstResponder()
            })
        } else if lastNameTextView.isFirstResponder {
            UIView.animate(withDuration: 0.7, animations: { [weak self] in
                guard let sself = self else { return }
                sself.lastNameTextView.resignFirstResponder()
            })
        } else if patronymicTextView.isFirstResponder {
            UIView.animate(withDuration: 0.7, animations: { [weak self] in
                guard let sself = self else { return }
                sself.patronymicTextView.resignFirstResponder()
            })
        }
        if tap != nil {
            view.removeGestureRecognizer(tap!)
        }
        pickerEnabled()
        datePickerEnabled()
        isChanged = true
    }
    
    func pickerEnabled() {
        if picker != nil {
            picker?.removeFromSuperview()
        }
    }
    
    func datePickerEnabled() {
        if datePicker != nil {
            datePicker?.removeFromSuperview()
        }
    }
}

extension EditController: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        view.addGestureRecognizer(tap!)
        isChanged = true
        return true
    }
    
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


