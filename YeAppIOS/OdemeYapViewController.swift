//
//  OdemeYapViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class OdemeYapViewController: UIViewController {

    @IBOutlet weak var odemeYapBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        odemeYapBtn.layer.cornerRadius=15
        odemeYapBtn.layer.masksToBounds=true
    }


}
