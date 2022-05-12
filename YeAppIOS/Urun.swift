//
//  Urun.swift
//  YeAppIOS
//
//  Created by bigsur on 11.05.2022.
//

import Foundation
import UIKit

class Urun {
    
    
    
    var urunImg:UIImage
    var urunName:String
    var urunCount:String
    var urunPrice:String
    
    init(urunImg:UIImage, urunName:String, urunCount:String, urunPrice:String)
    {
        self.urunImg = urunImg
        self.urunName = urunName
        self.urunCount = urunCount
        self.urunPrice = urunPrice
    }
}
