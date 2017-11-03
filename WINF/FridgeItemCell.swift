//
//  FridgeItemCell.swift
//  What's in my Fridge?
//
//  Created by Vatsal Rustagi on 6/30/17.
//  Copyright © 2017 Vatsalr23. All rights reserved.
//

import UIKit

class FridgeItemCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var bgView: UIView!

    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func updateUI(item: Items){
        let borderColor : UIColor = UIColor(red: 0.64, green: 0.87, blue: 0.82, alpha: 1.00)
        bgView.layer.borderColor = borderColor.cgColor
        bgView.layer.borderWidth = 2.0
        bgView.layer.cornerRadius = 3.0
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        bgView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        bgView.layer.shadowRadius = 1.0
        bgView.layer.shadowOpacity = 0.8
        
        nameLabel.text = item.name
        
        if item.expiration <= 0{
            dateLabel.text = "Expired"
            bgView.backgroundColor = UIColor.gray
        }else{
            dateLabel.text = "\(item.expiration) day" + (item.expiration > 1 ? "s" : "")
        }
        
//        if let date = item.date{
//            let newDate = Date(timeIntervalSinceNow: 0)
//            let expiry = (Int(date.timeIntervalSince(newDate)) / (60*60*24)) + 1
//
//            return
//        }
        
//       dateLabel.text = "no info"
        
    }
 
}
