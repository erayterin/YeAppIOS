//
//  UrunCollectionViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit



class UrunCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var urunImg: UIImageView!
    @IBOutlet weak var urunName: UILabel!
    @IBOutlet weak var urunCount: UILabel!
    @IBOutlet weak var urunPrice: UILabel!
    
    
    
    var urunSayisi: Int = 1
    
    
    
    
    
    
    @IBAction func sptEkle(_ sender: Any) {
        
        if Sepet.sepet.urunSepetList.count > 0{
            
            if urunKontrol() == false{
                Sepet.sepet.urunSepetList.append(
                    Urun(
                        urunImg: urunImg.image!,
                        urunName: urunName.text!,
                        urunCount: urunCount.text!,
                        urunPrice: urunPrice.text!))
            }
        }
        else{
            Sepet.sepet.urunSepetList.append(
                Urun(
                    urunImg: urunImg.image!,
                    urunName: urunName.text!,
                    urunCount: urunCount.text!,
                    urunPrice: urunPrice.text!))
        }
        
        //print(urunPrice.text)
        
        /*for urunSepet in Sepet.sepet.urunSepetList {
            print(urunSepet.urunName+" ",urunSepet.urunImg)
        }*/
        //print("Sepet Count : ", Sepet.sepet.urunSepetList[])
    }
    
    func urunKontrol()->Bool{
        for urunSepet in Sepet.sepet.urunSepetList{
            if urunSepet.urunName == urunName.text{
                
                urunSepet.urunCount = urunSayisiEkle(urunSepetCount: urunSepet.urunCount)
                print("Ürün Adı : ",urunSepet.urunName ,"Ürün Sayısı : ",urunSepet.urunCount)
                return true
            }
            
        }
        return false
    }
    func urunSayisiEkle(urunSepetCount:String)->String{
        urunSayisi = (urunCount.text! as NSString).integerValue
        if urunSayisi != 0
        {
            urunSayisi += (urunSepetCount as NSString).integerValue
            
        }
        
        return urunSayisi.description
    }
    @IBAction func urunAzaltBtn(_ sender: Any) {
        urunSayisi = (urunCount.text! as NSString).integerValue
        if urunSayisi != 1
        {
            urunSayisi = urunSayisi-1
        }
        
        urunCount.text = urunSayisi.description
        
    }
    @IBAction func urunArttirBtn(_ sender: Any) {
        urunSayisi = (urunCount.text! as NSString).integerValue
        urunSayisi = urunSayisi+1
        urunCount.text = urunSayisi.description
    }
}
