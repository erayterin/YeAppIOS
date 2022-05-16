//
//  SiparisDetayViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit
import Firebase

class SiparisDetayViewController: UIViewController {

    @IBOutlet weak var tamamlandiBtn: UIButton!
    let currentUser=Auth.auth().currentUser!.uid
    override func viewDidLoad() {
        super.viewDidLoad()

        if currentUser != "ihPSoJT6NLSPwpgdYRTJcVrQfmp2" {
            tamamlandiBtn.isHidden=true
        }else{
            tamamlandiBtn.isHidden=false
        }
    }
    

}
