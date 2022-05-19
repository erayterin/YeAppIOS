//
//  SiparislerimViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit
import Firebase

class SiparislerimViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var siparislerTableView: UITableView!
    
    var siparisTarih = [String]()
    var siparisId = [String]()
    var siparisToplamFiyat = [String]()
    var siparisImage = [String]()
    
    let currentUser=Auth.auth().currentUser!.uid
    let db=Firestore.firestore()
    var siparislerCell = "siparislerCell"
    var id = ""
    var toplam = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        siparislerTableView.dataSource = self
        siparislerTableView.delegate = self
        
        if currentUser == "ihPSoJT6NLSPwpgdYRTJcVrQfmp2"{
            getSiparislerimAdmin()
        }else{
            getSiparislerim()
        }
        
        
    }
    
    // Kaç satır olucak
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return siparisId.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "siparislerCell", for: indexPath) as! SiparislerimTableViewCell
        cell.siparisId.text = self.siparisId[indexPath.row]
        cell.siparisUrunTarih.text = self.siparisTarih[indexPath.row]
        cell.siparisUrunImg.image = UIImage(named: "hamburger")
        cell.siparisToplamFiyat.text = self.siparisToplamFiyat[indexPath.row]
        cell.siparisDetaylar.text = "Detaylar →"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        id = siparisId[indexPath.row]
        toplam = siparisToplamFiyat[indexPath.row]
        performSegue(withIdentifier: "toSiparisDetay", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        if segue.identifier == "toSiparisDetay" {
            let destinationVC = segue.destination as! SiparisDetayViewController
        
            destinationVC.secilenId = id
            destinationVC.toplam = toplam
        }
    }
    
    
    
    
    func getSiparislerim(){
        self.siparisTarih.removeAll()
        self.siparisToplamFiyat.removeAll()
        self.siparisId.removeAll()
        db.collection("Siparisler").document(currentUser).collection("Siparis").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Hata Urunler")
            }else{
                for document in snapshot!.documents{
                    self.siparisId.append(document.documentID)
                    self.siparislerTableView.reloadData()
    
                    
                    if let date = document.get("date") as? String{
                                
                        self.siparisTarih.append(date)
                                
                    }
                            
                    if let toplam=document.get("toplam") as? String{
                        self.siparisToplamFiyat.append(toplam)
                                
                    }
                        
                }
            
            }
        }
    }
    
    func getSiparislerimAdmin(){
        self.siparisTarih.removeAll()
        self.siparisToplamFiyat.removeAll()
        self.siparisId.removeAll()
        db.collection("AdminSiparisDetay").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Hata Urunler")
            }else{
                for document in snapshot!.documents{
                    self.siparisId.append(document.documentID)
                    self.siparislerTableView.reloadData()
    
                
                    let date = document.get("date") as? String
                    self.siparisTarih.append(date!)
                                
                    
                            
                    let toplam=document.get("toplam") as? String
                    self.siparisToplamFiyat.append(toplam!)
                                
                    
                        
                }
            
            }
        }
    }
    
    
    

    
    func hataMesaji(titleInput: String,messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let  okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func nowDate()->String{
        let date = Date()
        let formatter = DateFormatter()
        
        formatter.timeZone = .current
        formatter.locale = .current
        formatter.dateFormat = "dd/MM/yyyy"
        
        return formatter.string(from: date)
    }
    
}
