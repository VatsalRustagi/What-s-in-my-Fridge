//
//  MainVC extension.swift
//  WINF
//
//  Created by Vatsal Rustagi on 11/3/17.
//  Copyright © 2017 Vatsalr23. All rights reserved.
//

import Foundation
import UDatePicker

extension MainVC{
    func showDatePicker() {
        if datePicker == nil {
            datePicker = UDatePicker(frame: view.frame, willDisappear: { date in
                if let selectedDate = date{
                    self.currentDateInTextField = selectedDate
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM/dd/yyyy"
                    self.expireInDays.text = "\(formatter.string(from: selectedDate))"
                    self.saveItem()
                }
            })
        }
        datePicker?.picker.barView.backgroundColor = UIColor(red: 0.46, green: 0.76, blue: 0.69, alpha: 1.00)
        datePicker?.picker.barView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        datePicker?.picker.barView.layer.shadowColor = UIColor.darkGray.cgColor
        datePicker?.picker.barView.layer.shadowRadius = 2.0
        datePicker?.picker.barView.layer.shadowOpacity = 0.8
        
        datePicker?.picker.doneButton.setTitleColor(.white, for: .normal)
        datePicker?.picker.datePicker.backgroundColor = UIColor(red: 0.73, green: 0.88, blue: 0.85, alpha: 1.00)
        datePicker?.picker.date = NSDate() as Date
        datePicker?.present(self)
    }
    
    func deleteExpiredItems(){
        if let objs = controller.fetchedObjects, objs.count > 0{
            for i in 0..<objs.count{
                let item = objs[i]
                if item.expiration <= 0{
                    context.delete(item)
                }
            }
        }
        
        appDelegate.saveContext()
    }
    
}
