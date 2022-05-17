//
//  Sepet.swift
//  YeAppIOS
//
//  Created by bigsur on 12.05.2022.
//

import Foundation

struct Sepet{
    
    static var sepet=Sepet()
    
    var urunSepetList = Array<Urun>()
    var teslimatUcreti : Double = 5.99
    func sepetHesapla()->Double{
        var sepetToplam:Double = 0
        if Sepet.sepet.urunSepetList.count>0 {
            for sepetUrun in Sepet.sepet.urunSepetList{
                sepetToplam = sepetToplam + ((sepetUrun.urunPrice as NSString).doubleValue * (sepetUrun.urunCount as NSString).doubleValue)
            }
            return sepetToplam+self.teslimatUcreti
        }
        
        return 0
    }
    
}
