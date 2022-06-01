//
//  KategoriCollectionViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit

protocol KategoriCollectionProtocol {
    func getUrun(kategoriUrunIsim:String)
    func tikla(index : Int)
}

class KategoriCollectionViewCell: UICollectionViewCell {
    
    var delegate : KategoriCollectionProtocol?
    var index : IndexPath?
    
   
    @IBOutlet weak var kategoriUrunImage: UIButton!
    @IBOutlet weak var kategoriUrunIsim: UILabel!
    @IBAction func kategoriUrunBtn(_ sender: Any) {
        if let kategoriUrunIsim = kategoriUrunIsim.text{
            delegate?.getUrun(kategoriUrunIsim: kategoriUrunIsim)
            delegate?.tikla(index: (index?.row)!)
            print(kategoriUrunIsim)
        }
        
    }
    
    
}
