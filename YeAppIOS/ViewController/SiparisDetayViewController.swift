//
//  SiparisDetayViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit
import Firebase
import SDWebImage

class SiparisDetayViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    

    
    @IBOutlet weak var siparisDetayCollectionView: UICollectionView!
    @IBOutlet weak var siparisDetayId: UILabel!
    @IBOutlet weak var siparisDetayAdres: UITextView!
    @IBOutlet weak var siparisDetayAraToplam: UILabel!
    @IBOutlet weak var siparisDetayTeslimatUcreti: UILabel!
    @IBOutlet weak var siparisDetayToplam: UILabel!
    @IBOutlet weak var tamamlandiBtn: UIButton!
    let currentUser=Auth.auth().currentUser!.uid
    let db=Firestore.firestore()
    
    var siparisDetayUrunImg = [String]()
    var siparisDetayUrunAdi = [String]()
    var siparisDetayUrunAdet = [String]()
    var siparisDetayUrunFiyat = [String]()
    
    var siparisDetayCell = "siparisDetayCell"
    var secilenId = ""
    var toplam = ""

    
    override func viewDidLoad() {
        super.viewDidLoad()
        siparisDetayCollectionView.dataSource = self
        siparisDetayCollectionView.delegate = self
        
        siparisDetayId.text = secilenId
        self.siparisDetayToplam.text = toplam+" ₺"
        let araToplam = Int(toplam)! - (5)
        self.siparisDetayAraToplam.text = String(araToplam)+" ₺"

        siparisDetayTeslimatUcreti.text = "5 ₺"

        getSiparisDetay()
        
        
        
        if currentUser == "ihPSoJT6NLSPwpgdYRTJcVrQfmp2" {
            getAdresAdmin()
            tamamlandiBtn.isHidden=false
        }else{
            getAdres()
            tamamlandiBtn.isHidden=true
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.siparisDetayUrunImg.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let siparisDetayCell = collectionView.dequeueReusableCell(withReuseIdentifier: "siparisDetayCell", for: indexPath) as! SiparisDetayCollectionViewCell
        
        siparisDetayCell.siparisDetayUrunImg.sd_setImage(with: URL(string:siparisDetayUrunImg[indexPath.row]))
                
        siparisDetayCell.siparisDetayUrunName.text = self.siparisDetayUrunAdi[indexPath.row]
        
        siparisDetayCell.siparisDetayUrunAdet.text = self.siparisDetayUrunAdet[indexPath.row]
        
        siparisDetayCell.siparisDetayUrunFiyat.text = self.siparisDetayUrunFiyat[indexPath.row]+" ₺"
        
        
        return siparisDetayCell
    }
    
    func getSiparisDetay(){
        
        siparisDetayUrunFiyat.removeAll()
        siparisDetayUrunAdet.removeAll()
        siparisDetayUrunAdi.removeAll()
        siparisDetayUrunImg.removeAll()
        db.collection("SiparisDetay").document(secilenId).collection("Urunler").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Hata Urunler")
            }else{
                for document in snapshot!.documents{
                 if let resim = document.get("resim") as? String {
                        self.siparisDetayUrunImg.append(resim)
                        print("Gelen Resim : ",resim)
                        print("Listedeki : ",self.siparisDetayUrunImg.first)
                    }
                    self.siparisDetayCollectionView.reloadData()
                    let ad = document.get("urunAd") as? String
                    self.siparisDetayUrunAdi.append(ad!)
                    let adet = document.get("adet") as? String
                    self.siparisDetayUrunAdet.append(adet!)
                    let fiyat = document.get("urunFiyat") as? String
                    self.siparisDetayUrunFiyat.append(fiyat!)
                }
            
            }
        }
    }
    
    
    
    @IBAction func deleteSiparis(_ sender: Any) {
        db.collection("AdminSiparisDetay").document(secilenId).delete()
        performSegue(withIdentifier: "toSiparisGit", sender: nil)
    }
    
    
    func getAdresAdmin(){

        db.collection("AdminSiparisDetay").document(secilenId).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Hata Urunler")
            }else{
                                     
                if let adres = snapshot?.get("adres") as? String{
                    self.siparisDetayAdres.text = adres
                    self.siparisDetayAdres.isEditable=false
                }
                    

            }
        }
    }
    
    func getAdres(){
        let docRef=db.collection("Users").document(currentUser)
        
        docRef.addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                if snapshot != nil {
                    self.siparisDetayAdres.text=snapshot?.get("adres") as? String
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

}
