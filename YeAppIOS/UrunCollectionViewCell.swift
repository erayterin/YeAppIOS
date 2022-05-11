//
//  UrunCollectionViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit

protocol UrunCollectionProtocol {
    func sepeteEkle(index : Int)
}

class UrunCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var urunImg: UIImageView!
    @IBOutlet weak var urunName: UILabel!
    @IBOutlet weak var urunCount: UILabel!
    @IBOutlet weak var urunPrice: UILabel!
    
    
    var urunSayisi: Int = 1
    
    var delegate: UrunCollectionProtocol?
    var index: IndexPath?
    
    @IBAction func septEkleBtn(_ sender: Any) {
        delegate?.sepeteEkle(index: (index?.row)!)
    }
    
    
    
    @IBAction func urunAzaltBtn(_ sender: Any) {
        urunSayisi = (urunCount.text! as NSString).integerValue
        if urunSayisi != 0
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
