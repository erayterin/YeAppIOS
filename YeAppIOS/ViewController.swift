//
//  ViewController.swift
//  YeAppIOS
//
//  Created by bigsur on 8.05.2022.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var girisYapBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        girisYapBtn.layer.cornerRadius=25
        girisYapBtn.layer.masksToBounds=true
        
    }
        

}

