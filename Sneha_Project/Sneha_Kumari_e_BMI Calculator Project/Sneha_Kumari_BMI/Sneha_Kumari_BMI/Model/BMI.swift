//
//  BMI.swift
//  Sneha_Kumari_BMI
//
//  Created by Sneha on 4/15/20.
//  Copyright © 2020 Mac. All rights reserved.
//

import Foundation
class Bmi {
    var value: Double
    var message: String
    var links: [String]
    
    init(value: Double, message: String, links: [String]) {
        self.value = value
        self.message = message
        self.links = links
    }
}
