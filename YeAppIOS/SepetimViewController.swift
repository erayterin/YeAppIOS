//
//  SepetimViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit

class SepetimViewController: UIViewController {

    @IBOutlet weak var urunImg: UIImageView!
    
    @IBOutlet weak var urunName: UILabel!
    @IBOutlet weak var urunCount: UILabel!
    @IBOutlet weak var urunPrice: UILabel!
    @IBOutlet weak var odemeYapBtn: UIButton!
    @IBOutlet weak var urunSilImg: UIImageView!
    
    var urunNameTxt = ""
    var urunImgTxt = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        /*urunImg.image = UIImage(named : urunImgTxt)
        urunName.text = urunNameTxt*/
        odemeYapBtn.layer.cornerRadius=15
        odemeYapBtn.layer.masksToBounds=true
        
    }

}
