//
//  SepetimViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit

class SepetimViewController: UIViewController {

   
    @IBOutlet weak var odemeYapBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        odemeYapBtn.layer.cornerRadius=15
        odemeYapBtn.layer.masksToBounds=true
        
    }

}
