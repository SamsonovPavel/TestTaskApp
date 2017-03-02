//
//  Helper.swift
//  TestTaskApp
//
//  Created by Pavel Samsonov on 02.03.17.
//  Copyright © 2017 Pavel Samsonov. All rights reserved.
//

import Foundation
import UIKit

class Helper: NSObject {
}

extension EditController {    
    func saveContent() {
        saveChangeContent()
        textViewResponders()
        delegate?.updateUI()
        isChanged = false
    }
    
    func validation(string: String) -> Bool {
        var valid = false
        
        let validation = CharacterSet.alphanumerics.inverted
        let result = string.components(separatedBy: validation)
        
        if result.count > 1 {
            valid = true
        } else {
            let validationDigits = CharacterSet.decimalDigits
            let result = string.components(separatedBy: validationDigits)
            
            if result.count > 1 {
                valid = true
            }
        }
        return valid
    }
    
    func validationAlert(title: String) {
        let message = "Ошибка ввода. Допустимы только строчные и прописные символы"
        let titleOk = "Ок"
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertOk = UIAlertAction(title: titleOk, style: .default, handler: nil)
        
        alertController.addAction(alertOk)
        self.present(alertController, animated: true, completion: nil)
    }
    
    func saveChangeContent() {
        if validation(string: firstNameTextView.text) {
            validationAlert(title: "Имя")
        } else {
            userDefault.set(firstNameTextView.text, forKey: firstNameKey)
        }
        
        if validation(string: lastNameTextView.text) {
            validationAlert(title: "Фамилия")
        } else {
            userDefault.set(lastNameTextView.text, forKey: lastNameKey)
        }
        
        if validation(string: patronymicTextView.text) {
            validationAlert(title: "Отчество")
        } else {
            userDefault.set(patronymicTextView.text, forKey: patronymicKey)
        }
        
        if (datePicker != nil) {
            handleDatePicker(sender: datePicker!)
        } else if (birthdayCell != nil) {
            userDefault.set(birthdayCell?.titleTextLabel.text, forKey: birthdayKey)
        }
        
        userDefault.set(birthdayCell?.titleTextLabel.text, forKey: birthdayKey)
        
        if let text = genderText {
            userDefault.set(text, forKey: genderKey)
        }
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
        if let tapOn = tap {
            view.removeGestureRecognizer(tapOn)
        }
        isChanged = true
    }
}


























