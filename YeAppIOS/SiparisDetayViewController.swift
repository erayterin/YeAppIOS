//
//  SiparisDetayViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit
import Firebase

class SiparisDetayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var siparisDetayTableView: UITableView!
    @IBOutlet weak var siparisDetayId: UILabel!
    @IBOutlet weak var siparisDetayAdres: UITextView!
    @IBOutlet weak var siparisDetayAraToplam: UILabel!
    @IBOutlet weak var siparisDetayTeslimatUcreti: UILabel!
    @IBOutlet weak var siparisDetayToplam: UILabel!
    @IBOutlet weak var tamamlandiBtn: UIButton!
    
    
    var siparisDetayUrunImg = [String]()
    var siparisDetayUrunAdi = [String]()
    var siparisDetayUrunAdet = [String]()
    var siparisDetayUrunFiyat = [String]()
    
    var siparisDetayCell = "siparisDetayCell"
    
    let currentUser=Auth.auth().currentUser!.uid
    override func viewDidLoad() {
        super.viewDidLoad()
        siparisDetayTableView.dataSource = self
        siparisDetayTableView.delegate = self
        
        siparisDetayId.text = "2fgfdgf616s1f6d1f6sd1f6sd1gghgjhsbd"
        siparisDetayAdres.text = "YeApp Ofis"
        siparisDetayAraToplam.text = "145"
        siparisDetayTeslimatUcreti.text = "5"
        siparisDetayToplam.text = "150"
        
        
        siparisDetayUrunImg.append("hamburger")
        siparisDetayUrunAdi.append("Hamburger")
        siparisDetayUrunAdet.append("5")
        siparisDetayUrunFiyat.append("55 ₺")
        
        siparisDetayUrunImg.append("hamburger")
        siparisDetayUrunAdi.append("Hamburger")
        siparisDetayUrunAdet.append("5")
        siparisDetayUrunFiyat.append("55 ₺")
        
        if currentUser != "ihPSoJT6NLSPwpgdYRTJcVrQfmp2" {
            tamamlandiBtn.isHidden=true
        }else{
            tamamlandiBtn.isHidden=false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siparisDetayUrunImg.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "siparisDetayCell", for: indexPath) as! SiparisDetayTableViewCell
        
        cell.siparisDetayUrunAdi.text = self.siparisDetayUrunAdi[indexPath.row]
        cell.siparisDetayUrunImg.image = UIImage(named:self.siparisDetayUrunImg[indexPath.row])
        cell.siparisDetayUrunAdet.text = self.siparisDetayUrunAdet[indexPath.row]
        cell.siparisDetayUrunFiyat.text = self.siparisDetayUrunFiyat[indexPath.row]
        //cell.siparisUrunImg.image = "hamburger"
        
        return cell
    }
    

}
