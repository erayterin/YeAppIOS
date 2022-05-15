//
//  UyeOlViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class UyeOlViewController: UIViewController {

    @IBOutlet weak var uyeOlBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uyeOlBtn.layer.cornerRadius=25
        uyeOlBtn.layer.masksToBounds=true
    }
    

}
