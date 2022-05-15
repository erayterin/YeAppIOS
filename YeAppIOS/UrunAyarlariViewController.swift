//
//  UrunAyarlariViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class UrunAyarlariViewController: UIViewController {

    @IBOutlet weak var kategoriEkleBtn: UIButton!
    @IBOutlet weak var urunEkleBtn: UIButton!
    @IBOutlet weak var urunGuncelleBtn: UIButton!
    @IBOutlet weak var urunSilBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        kategoriEkleBtn.layer.cornerRadius=25
        kategoriEkleBtn.layer.masksToBounds=true
        
        urunEkleBtn.layer.cornerRadius=25
        urunEkleBtn.layer.masksToBounds=true
        
        urunGuncelleBtn.layer.cornerRadius=25
        urunGuncelleBtn.layer.masksToBounds=true
        
        urunSilBtn.layer.cornerRadius=25
        urunSilBtn.layer.masksToBounds=true
    }
    

    

}
