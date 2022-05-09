//
//  UrunGuncelleViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class UrunGuncelleViewController: UIViewController {

    @IBOutlet weak var urunGuncelleBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        urunGuncelleBtn.layer.cornerRadius=15
        urunGuncelleBtn.layer.masksToBounds=true
    }

}
