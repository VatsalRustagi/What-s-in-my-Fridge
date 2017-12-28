//
//  ItemDetailsVC.swift
//  WINF
//
//  Created by Vatsal Rustagi on 8/29/17.
//  Copyright © 2017 Vatsalr23. All rights reserved.
//

import UIKit
import UDatePicker
import UserNotifications

class ItemDetailsVC: UIViewController {

    @IBOutlet weak var fridgeItem: UITextField!
    @IBOutlet weak var expiryBtn: UIButton!
    @IBAction func newDate(_ sender: UIButton) {
        showDatePicker()
    }
    
    var itemToEdit: Items?
    var datePicker: UDatePicker? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        if itemToEdit != nil{
            fridgeItem.text = itemToEdit!.name
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if let item = itemToEdit{
            item.name = fridgeItem.text!
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        if let item = itemToEdit{
            
            if let notificationID = item.id{
                UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [notificationID])
            }
            
            context.delete(item)
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    func showDatePicker() {
        if datePicker == nil {
            datePicker = UDatePicker(frame: view.frame, willDisappear: { date in
                if let selectedDate = date{
                    let formatter = DateFormatter()
                    formatter.dateFormat = "MM/dd/yyyy"
                    self.expiryBtn.setTitle("\(formatter.string(from: selectedDate))", for: .normal)
                    
                    if let item = self.itemToEdit{
                        item.date = date
                        let newDate = Date(timeIntervalSinceNow: 0)
                        let expiry = (Int((date?.timeIntervalSince(newDate))!) / (60*60*24)) + 1
                        item.expiration = Int64(expiry)
                    }
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
    

}
