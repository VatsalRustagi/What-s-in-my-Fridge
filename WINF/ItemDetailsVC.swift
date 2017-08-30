//
//  ItemDetailsVC.swift
//  WINF
//
//  Created by Vatsal Rustagi on 8/29/17.
//  Copyright © 2017 Vatsalr23. All rights reserved.
//

import UIKit

class ItemDetailsVC: UIViewController {

    @IBOutlet weak var fridgeItem: UITextField!
    @IBOutlet weak var expiresIn: UITextField!
    
    var itemToEdit: Items?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        if itemToEdit != nil{
            fridgeItem.text = itemToEdit!.name
            expiresIn.text = "\(itemToEdit!.expiration)"
        }
    }
    
    @IBAction func savePressed(_ sender: UIButton) {
        if let item = itemToEdit{
            item.name = fridgeItem.text!
            if let i = Int(expiresIn.text!){
                item.expiration = Int64(i)
            }
            
            appDelegate.saveContext()
        }
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func deletePressed(_ sender: UIButton) {
        if let item = itemToEdit{
            context.delete(item)
            appDelegate.saveContext()
        }
        dismiss(animated: true, completion: nil)
    }
    

}
