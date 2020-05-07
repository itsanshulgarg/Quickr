//
//  AdsModel.swift
//  Quickr
//
//  Created by Anshul Garg on 06/05/20.
//  Copyright © 2020 Anshul Garg. All rights reserved.
//

import Foundation
import UIKit

class AdModel{
    var title : String?
    var category : String?
    var price : String?
    var imageURL : String?
    var adOwner : String?
    
    init(title : String, category : String, price : String, imageURL : String, adOwner : String){
        self.title = title
        self.category = category
        self.price = price
        self.imageURL = imageURL
        self.adOwner = adOwner
    }
}

