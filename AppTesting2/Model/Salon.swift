//
//  Salon.swift
//  AppTesting2
//
//  Created by Sovorn on 10/24/18.
//  Copyright © 2018 Sovorn. All rights reserved.
//

import UIKit

class Salon {
    var phone: String
    var name: String
    var service: String
    var price: String
    var discount: String
    var description: String
    
    var profileUrl: String
    var image1: String
    var image2: String
    var image3: String
    var image4: String
    var image5: String
    var image6: String
    var image7: String
    var image8: String
    var image9: String
    var image10: String
    
    init(dic: [String: String]) {
        self.phone = dic["phone"]!
        self.name = dic["name"]!
        self.service = dic["service"]!
        self.price = dic["price"]!
        self.discount = dic["discount"]!
        self.description = dic["description"]!
        self.profileUrl = dic["profileUrl"]!
        
        self.image1 = dic["image1"]!
        self.image2 = dic["image2"]!
        self.image3 = dic["image3"]!
        self.image4 = dic["image4"]!
        self.image5 = dic["image5"]!
        self.image6 = dic["image6"]!
        self.image7 = dic["image7"]!
        self.image8 = dic["image8"]!
        self.image9 = dic["image9"]!
        self.image10 = dic["image10"]!
        
    }
}
