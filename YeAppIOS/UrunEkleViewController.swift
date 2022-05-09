//
//  UrunEkleViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class UrunEkleViewController: UIViewController {

    @IBOutlet weak var urunEkleBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        urunEkleBtn.layer.cornerRadius=15
        urunEkleBtn.layer.masksToBounds=true
    }


}
