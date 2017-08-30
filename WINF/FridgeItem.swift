//
//  FridgeItem.swift
//  What's in my Fridge?
//
//  Created by Vatsal Rustagi on 6/30/17.
//  Copyright © 2017 Vatsalr23. All rights reserved.
//

import Foundation

class FridgeItem{
    private var _itemName: String!
    private var _expirationDate: Int!
    
    var itemName: String{
        if _itemName == nil{
            _itemName = ""
        }
        return _itemName
    }
    
    var expirationDate: Int{
        if _expirationDate == nil{
            _expirationDate = 0
        }
        return _expirationDate
    }
    
    init(itemName: String, expirationDate: Int) {
        self._itemName = itemName
        self._expirationDate = expirationDate
    }
}
