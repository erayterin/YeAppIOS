//
//  ProfileViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var girisYapBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        girisYapBtn.layer.cornerRadius=25
        girisYapBtn.layer.masksToBounds=true
    }
    

}
