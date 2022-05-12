//
//  SiparisOnayiViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 11.05.2022.
//

import UIKit

class SiparisOnayiViewController: UIViewController {

    
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var onayText: UILabel!
    @IBOutlet weak var siparisBilgiText: UILabel!
    @IBOutlet weak var anasayfayaDonBtn: UIButton!
    var tikla=true
    override func viewDidLoad() {
        super.viewDidLoad()

        anasayfayaDonBtn.layer.cornerRadius=15
        anasayfayaDonBtn.layer.masksToBounds=true
        
        changeError()
    }
    
    func changeView(){
        if tikla==false {
            tikla=true
            changeError()
        }else{
            tikla=false
            changeOK()
        }
    }
    
    func changeOK() {
        image.image=UIImage (named:"pay")
        onayText?.text="Teşekkürler"
        
        siparisBilgiText?.text="Siparişiniz onaylandı"
        
    }
    
    
    func changeError(){
        image.image=UIImage (named:"basarisiz_x")
        onayText?.text="Hata"
        
        siparisBilgiText?.text="Siparişiniz onaylanmadı"
    }
    
    
    
}
