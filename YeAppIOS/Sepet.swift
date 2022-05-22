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
    var teslimatUcreti : Int = 5
    func sepetHesapla()->Int{
        var sepetToplam:Int = 0
        if Sepet.sepet.urunSepetList.count>0 {
            for sepetUrun in Sepet.sepet.urunSepetList{
                sepetToplam = sepetToplam + ((sepetUrun.urunPrice as NSString).integerValue * (sepetUrun.urunCount as NSString).integerValue)
            }
            return sepetToplam+self.teslimatUcreti
        }
        
        return 0
    }
    
}
