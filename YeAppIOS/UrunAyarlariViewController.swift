//
//  UrunAyarlariViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import Firebase

class UrunAyarlariViewController: UIViewController {

    @IBOutlet weak var kategoriEkleBtn: UIButton!
    @IBOutlet weak var urunEkleBtn: UIButton!
    @IBOutlet weak var urunGuncelleBtn: UIButton!
    @IBOutlet weak var urunSilBtn: UIButton!
    @IBOutlet weak var merhabaText: UILabel!
    let currentUser=Auth.auth().currentUser!.uid
    let db=Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        kategoriEkleBtn.layer.cornerRadius=25
        kategoriEkleBtn.layer.masksToBounds=true
        
        urunEkleBtn.layer.cornerRadius=25
        urunEkleBtn.layer.masksToBounds=true
        
        urunGuncelleBtn.layer.cornerRadius=25
        urunGuncelleBtn.layer.masksToBounds=true
        
        urunSilBtn.layer.cornerRadius=25
        urunSilBtn.layer.masksToBounds=true
        getProfilBilgi()
    }
    
    func getProfilBilgi(){
        let docRef=db.collection("Users").document(currentUser)
        
        docRef.addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                if snapshot != nil {
                    self.merhabaText.text="Merhaba , "+((snapshot?.get("isim") as? String)!)
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
