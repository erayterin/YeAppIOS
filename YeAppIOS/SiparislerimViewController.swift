//
//  SiparislerimViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit

class SiparislerimViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var siparislerTableView: UITableView!
    
    
    var siparisUrunImg = [String]()
    var siparisTarih = [String]()
    var siparisId = [String]()
    var siparisToplamFiyat = [String]()
    
    
    var siparislerCell = "siparislerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        siparislerTableView.dataSource = self
        siparislerTableView.delegate = self
        
        siparisId.append("klqwjeqkwlje2312")
        siparisUrunImg.append("hamburger")
        siparisTarih.append("17/05/2022")
        siparisToplamFiyat.append("55 ₺")
        
        siparisId.append("klqwjeqkwlje2312")
        siparisUrunImg.append("hamburger")
        siparisTarih.append("17/05/2022")
        siparisToplamFiyat.append("55 ₺")
        
    }
    
    // Kaç satır olucak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siparisId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "siparislerCell", for: indexPath) as! SiparislerimTableViewCell
        cell.siparisId.text = self.siparisId[indexPath.row]
        cell.siparisUrunTarih.text = self.siparisTarih[indexPath.row]
        cell.siparisUrunImg.image = UIImage(named:self.siparisUrunImg[indexPath.row])
        cell.siparisToplamFiyat.text = self.siparisToplamFiyat[indexPath.row]
        cell.siparisDetaylar.text = "Detaylar →"
        //cell.siparisUrunImg.image = "hamburger"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toSiparisDetay", sender: nil)
    }


}
