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
