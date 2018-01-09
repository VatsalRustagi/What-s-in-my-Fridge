//
//  ViewController.swift
//  What's in my Fridge?
//
//  Created by Vatsal Rustagi on 6/30/17.
//  Copyright © 2017 Vatsalr23. All rights reserved.
//

import UIKit
import CoreData
import RevealingSplashView
import Floaty
import UserNotifications
import UDatePicker
import Emoji

class MainVC: UIViewController{
    
    var controller: NSFetchedResultsController<Items>!
    var datePicker: UDatePicker? = nil
    var currentDateInTextField: Date? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert,.sound,.badge], completionHandler: {didAllow, error in})
        
        attemptFetch()
        
        let revealingSplashView = RevealingSplashView(iconImage: #imageLiteral(resourceName: "milk"),iconInitialSize: CGSize(width: 70, height: 70), backgroundColor: UIColor(red:0.29, green:0.64, blue:0.54, alpha:0.95))
        revealingSplashView.animationType = .squeezeAndZoomOut
        self.view.addSubview(revealingSplashView)

        revealingSplashView.startAnimation(){
            self.attemptFetch()
        }
        
        initUI()
        
        optionsButton.addItem("Clear All", icon: #imageLiteral(resourceName: "trash"), handler: {item in
            self.deleteAllItems()
        })
        
        optionsButton.addItem("Clear Expired", icon: #imageLiteral(resourceName: "broom"), handler: {item in
            self.deleteExpiredItems()
        })
        
        
        optionsButton.openAnimationType = .pop
        
        self.fridgeItem.delegate = self
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? ItemDetailsVC{
            if let item = sender as? Items{
                dest.itemToEdit = item
            }
        }
    }
    
    func dismissKeyboard(){
        view.endEditing(true)
    }
    
    func attemptFetch(){
        let request: NSFetchRequest<Items> = Items.fetchRequest()
        
        let expirationSort = NSSortDescriptor(key: "date", ascending: false)
        
        request.sortDescriptors = [expirationSort]
        
        let controller = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        controller.delegate = self
        
        self.controller = controller
        
        do {
//            self.updateExpiryDates()
            try controller.performFetch()
        }catch{
            let error = error as NSError
            print("\(error)")
        }
    }
    
    func deleteAllItems(){
        if let objs = controller.fetchedObjects, objs.count > 0{
            for i in 0..<objs.count{
                let item = objs[i]
                context.delete(item)
            }
        }
        appDelegate.saveContext()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    @objc func saveItem(){
        if check(){
            let item = Items(context: context)
            item.name = fridgeItem.text!
            if let date = currentDateInTextField{
                item.date = date
                let newDate = Date(timeIntervalSinceNow: 0)
                let expiry = (Int(date.timeIntervalSince(newDate)) / (60*60*24)) + 1
                item.expiration = Int64(expiry)
                if expiry > 0{
                    createNotification(item: item)
                }
            }
            else{
                item.date = Date(timeIntervalSinceNow: 0)
            }
            appDelegate.saveContext()
            currentDateInTextField = nil
            expiryBtn.setTitle("Pick Expiry Date", for: .normal)
        }
        dismissKeyboard()
    }
    
    func check() -> Bool{
        if !fridgeItem.hasText{
            fridgeItem.becomeFirstResponder()
            return false
        }
        
        if currentDateInTextField == nil{
            return false
        }
        
        return true
    }
    
    @IBOutlet weak var titleView: UILabel!
    @IBOutlet weak var fridgeItem: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var optionsButton: Floaty!
    @IBOutlet weak var detailsView: UIView!
    @IBOutlet weak var expiryBtn: UIButton!
    @IBOutlet weak var segmentedController: UISegmentedControl!
    @IBOutlet weak var addItemButton: UIButton!
    
    @IBOutlet weak var unitButton: UIButton!
    @IBOutlet weak var categoryButton: UIButton!
    @IBAction func addItem(_ sender: UIButton) {
        changeTextTo(message: "Welcome!")
        saveItem()
    }
    
    @IBAction func pickExpiryDate(_ sender: UIButton) {
        showDatePicker()
    }
}

// UITableView Delegate and Datasource

extension MainVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections{
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? FridgeItemCell{
            configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0{
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "ItemDetailsVC", sender: item)
        }
    }
    
    func configureCell(cell: FridgeItemCell, indexPath: NSIndexPath)
    {
        let item = controller.object(at: indexPath as IndexPath)
        cell.updateUI(item: item)
    }
}

// NSFetchResultControllerDelegate

extension MainVC: NSFetchedResultsControllerDelegate{
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch(type){
            case.update:
                if let indexPath = newIndexPath{
                    let cell = tableView.cellForRow(at: indexPath) as! FridgeItemCell
                    configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
                }
            break
            
            case .insert:
                if let indexPath = newIndexPath{
                    tableView.insertRows(at: [indexPath], with: .fade)
                }
            break
            
            case .delete:
                if let indexPath = indexPath{
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            break
            
            case.move:
                if let indexPath = indexPath{
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
                if let indexPath = newIndexPath{
                    tableView.insertRows(at: [indexPath], with: .fade)
                }
            break
        }
    }
}

extension MainVC: UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0{
            self.dismissKeyboard()
        }
        return true
    }
}

