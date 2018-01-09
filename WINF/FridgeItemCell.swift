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
        bgView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        bgView.layer.shadowColor = bgView.backgroundColor?.darker(by: 15)?.cgColor
        bgView.layer.shadowRadius = 1.5
        bgView.layer.shadowOpacity = 1.0
        
        var s = ":\(item.name!.lowercased()):"
        
        if !s.elementsEqual(s.emojiUnescapedString){
            s = s.emojiUnescapedString
        }else{
            s = "🍽"
        }
        
        nameLabel.text = item.name! + " \(s)"
        if let date = item.date{
            let newDate = Date(timeIntervalSinceNow: 0)
            let expiry = (Int(date.timeIntervalSince(newDate)) / (60*60*24)) + 1
            if expiry <= 0{
                dateLabel.text = "Expired"
                bgView.backgroundColor = UIColor.gray
            }else{
                dateLabel.text = "Expires in "+"\(expiry) day" + (expiry > 1 ? "s" : "")
            }
            return
        }
        dateLabel.text = "No Info"
    }
 
}
