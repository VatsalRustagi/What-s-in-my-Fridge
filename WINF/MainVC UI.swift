//
//  MainVC UI.swift
//  WINF
//
//  Created by Vatsal Rustagi on 1/9/18.
//  Copyright © 2018 Vatsalr23. All rights reserved.
//

import Foundation
import UIKit


extension MainVC{
    
    func initUI(){
        setupTableViewBG()
        setupDetailsView()
        let buttons = [expiryBtn, addItemButton, unitButton, categoryButton]
        for button in buttons{
            addShadowto(button: button!)
        }
        setupTitle()
        
        changeTextTo(message: "Welcome!")
    }
    
    func setupTableViewBG(){
        let imageView = UIImageView(frame: CGRect(x: tableView.center.x - 100, y: tableView.center.y - 150, width: 200, height: 300))
        imageView.image = #imageLiteral(resourceName: "fridge")
        imageView.contentMode = .center
        tableView.backgroundView = imageView
    }
    
    func setupDetailsView(){
        detailsView.layer.cornerRadius = 5.0
        detailsView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        detailsView.layer.shadowColor = detailsView.backgroundColor?.darker(by: 15)?.cgColor
        detailsView.layer.shadowRadius = 5.0
        detailsView.layer.shadowOpacity = 1.0
        detailsView.layer.masksToBounds = false
    }
    
    func addShadowto(button: UIButton){
        button.layer.cornerRadius = 5.0
        button.layer.shadowOffset = CGSize(width: 0, height: 2.5)
        button.layer.shadowColor = button.backgroundColor?.darker(by: 15)?.cgColor
        button.layer.shadowRadius = 0.0
        button.layer.shadowOpacity = 0.8
        button.layer.masksToBounds = false
    }
    
    func setupTitle(){
        titleView.layer.shadowOffset = CGSize(width: -2.0, height: 2.0)
        titleView.layer.shadowColor = titleView.textColor.cgColor
        titleView.textColor = UIColor.white
        titleView.layer.shadowRadius = 0.0
        titleView.layer.shadowOpacity = 0.8
        titleView.layer.masksToBounds = false
    }
    
    func changeTextTo(message: String){
        Timer.scheduledTimer(timeInterval: 10, target: self, selector: #selector(MainVC.resetText), userInfo: nil, repeats: false)
        
        UIView.transition(with: titleView, duration: 0.5, options: .transitionCrossDissolve, animations: {
            self.titleView.text = message
        }, completion: nil)
    }
    
    @objc func resetText(){
        UIView.transition(with: titleView, duration: 1.0, options: .transitionCrossDissolve, animations: {
            self.titleView.text = "What's In My Fridge?"
        }, completion: nil)
    }
}
