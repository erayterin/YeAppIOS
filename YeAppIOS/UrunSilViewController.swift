//
//  UrunSilViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class UrunSilViewController: UIViewController {

    @IBOutlet weak var urunSilBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        urunSilBtn.layer.cornerRadius=15
        urunSilBtn.layer.masksToBounds=true
    }
    
}
