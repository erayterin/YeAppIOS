//
//  SepetCollectionViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 12.05.2022.
//

import UIKit

protocol SepetCollectionProtocol {
    func sepetUrunSil(index: Int)
    func sepetUrunAzalt()
    func sepetUrunArttir()
}

class SepetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sepetUrunImg: UIImageView!
    
    @IBOutlet weak var sepetUrunName: UILabel!
    
    @IBOutlet weak var sepetUrunCount: UILabel!
    
    @IBOutlet weak var sepetUrunPrice: UILabel!
    
    var sepetUrunSayisi: Int = 1
    
    // Sepet Protocol
    var delegate : SepetCollectionProtocol?
    var index: IndexPath?
    
    // Sepet Fonksiyon
    func sepetUrunCountGuncelle(sepetUrunSayisi:Int)->Bool{
        for urunSepet in Sepet.sepet.urunSepetList{
            if urunSepet.urunName == sepetUrunName.text{
                
                urunSepet.urunCount = sepetUrunSayisi.description
                //print("Ürün Adı : ",urunSepet.urunName ,"Ürün Sayısı : ",urunSepet.urunCount)
                return true
            }
            
        }
        return false
    }
    
    
    // Button Action
    @IBAction func sepetUrunAzalt(_ sender: Any) {
        sepetUrunSayisi = (sepetUrunCount.text! as NSString).integerValue
        if sepetUrunSayisi != 0
        {
            
            sepetUrunSayisi = sepetUrunSayisi-1
            sepetUrunCountGuncelle(sepetUrunSayisi: sepetUrunSayisi)
        }
        
        sepetUrunCount.text = sepetUrunSayisi.description
        delegate?.sepetUrunAzalt()
    }
    
    @IBAction func sepetUrunArttir(_ sender: Any) {
        sepetUrunSayisi = (sepetUrunCount.text! as NSString).integerValue
        sepetUrunSayisi = sepetUrunSayisi+1
        sepetUrunCount.text = sepetUrunSayisi.description
        sepetUrunCountGuncelle(sepetUrunSayisi: sepetUrunSayisi)
        
        delegate?.sepetUrunArttir()
        //print(sepetUrunImg.image?.description)
    }
    
    
    
    
    @IBAction func sepetUrunSil(_ sender: Any) {
        delegate?.sepetUrunSil(index: (index?.row)!)
    }
    
   
}
