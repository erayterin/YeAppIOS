//
//  OdemeYapViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class OdemeYapViewController: UIViewController {

   
    @IBOutlet weak var odemeYapBtn: UIButton!
    @IBOutlet weak var kapidaBtn: UIButton!
    @IBOutlet weak var TRXBtn: UIButton!
    @IBOutlet weak var cuzdanKoduText: UILabel!
    @IBOutlet weak var copyBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        odemeYapBtn.layer.cornerRadius=15
        odemeYapBtn.layer.masksToBounds=true
        
    }
    
    
    @IBAction func clickKapida(_ sender: Any) {
        kapidaBtn.setImage(UIImage(named: "dolu"), for: .normal)
        TRXBtn.setImage(UIImage(named: "bos"), for: .normal)
    }
    
    
    @IBAction func clickTRX(_ sender: Any) {
        TRXBtn.setImage(UIImage(named: "dolu"), for: .normal)
        kapidaBtn.setImage(UIImage(named: "bos"), for: .normal)
    }
    
    
    @IBAction func clickCopy(_ sender: Any) {
        copyBtn.setImage(UIImage(named: "turuncutick"), for: .normal)
        
        UIPasteboard.general.string = cuzdanKoduText.text
    }
    
}
