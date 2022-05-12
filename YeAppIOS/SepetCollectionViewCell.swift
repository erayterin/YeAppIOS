//
//  SepetCollectionViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 12.05.2022.
//

import UIKit

class SepetCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var sepetUrunImg: UIImageView!
    
    @IBOutlet weak var sepetUrunName: UILabel!
    
    @IBOutlet weak var sepetUrunCount: UILabel!
    
    
    @IBOutlet weak var sepetUrunPrice: UILabel!
    
    var sepetUrunSayisi: Int = 1
    
    @IBAction func sepetUrunAzalt(_ sender: Any) {
        sepetUrunSayisi = (sepetUrunCount.text! as NSString).integerValue
        if sepetUrunSayisi != 0
        {
            sepetUrunSayisi = sepetUrunSayisi-1
        }
        
        sepetUrunCount.text = sepetUrunSayisi.description
    }
    
    @IBAction func sepetUrunArttir(_ sender: Any) {
        sepetUrunSayisi = (sepetUrunCount.text! as NSString).integerValue
        sepetUrunSayisi = sepetUrunSayisi+1
        sepetUrunCount.text = sepetUrunSayisi.description
        //print(sepetUrunImg.image?.description)
    }
    
    @IBAction func sepetUrunSil(_ sender: Any) {
        
    }
    
    
}
