//
//  ProfileViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {

    @IBOutlet weak var girisYapBtn: UIButton!
    @IBOutlet weak var adSoyadText: UITextField!
    @IBOutlet weak var adresText: UITextField!
    @IBOutlet weak var telNoText: UITextField!
    @IBOutlet weak var cuzdanAdresText: UITextField!
    @IBOutlet weak var mailText: UITextField!
    @IBOutlet weak var sifreText: UITextField!
    @IBOutlet weak var sifreTekrarText: UITextField!
    @IBOutlet weak var merhabaText: UILabel!
    let currentUser=Auth.auth().currentUser!.uid
    let db=Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        girisYapBtn.layer.cornerRadius=25
        girisYapBtn.layer.masksToBounds=true
        
        
        getProfilBilgi()
        
        
        
    }
    
    @IBAction func cikisYap(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            self.performSegue(withIdentifier: "profilToGiris", sender: nil)
        } catch {
            print("Hata")
        }
        
    }
    
    @IBAction func profilGuncelle(_ sender: Any) {
        
        
        let docRef=db.collection("Users").document(currentUser)
        var len=sifreText.text?.count
        if sifreText.text == "" || sifreTekrarText.text == ""  ||  len! < 6 || sifreText.text != sifreTekrarText.text{
            let firestoreUser = ["adres" :adresText.text!, "cuzdanAdres" : cuzdanAdresText.text! , "email" : mailText.text! , "id" : currentUser , "isim" : adSoyadText.text!,"telNo" : telNoText.text!]
            
            Firestore.firestore().collection("Users").document(currentUser).updateData(firestoreUser){
                (error) in
                if error != nil{
                    self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
                }else{
                    Auth.auth().currentUser?.updateEmail(to: self.mailText.text!)
                    if self.sifreText.text != "" || self.sifreTekrarText.text != ""{
                        if self.sifreText.text != self.sifreTekrarText.text {
                            self.hataMesaji(titleInput: "HATA", messageInput: "Şifreler farklı")
                        }else if len! < 6 {
                            self.hataMesaji(titleInput: "HATA", messageInput: "Şifre en az 6 karakter olmalıdır")
                        }
                    }else{
                        self.hataMesaji(titleInput: "Başarılı", messageInput: "Güncellendi")
                    }
                }
            }
        }else{
            let firestoreUser = ["adres" :adresText.text!, "cuzdanAdres" : cuzdanAdresText.text! , "email" : mailText.text! , "id" : currentUser , "isim" : adSoyadText.text!,"telNo" : telNoText.text!,"sifre" : sifreText.text!]
            
            Firestore.firestore().collection("Users").document(currentUser).updateData(firestoreUser){
                (error) in
                if error != nil{
                    self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
                }else{
                    Auth.auth().currentUser?.updateEmail(to: self.mailText.text!)
                    Auth.auth().currentUser?.updatePassword(to: self.sifreText.text!)
                    self.hataMesaji(titleInput: "Başarılı", messageInput: "Güncellendi")
                }
            }
        }
        
    }
    
    
    func getProfilBilgi(){
        let docRef=db.collection("Users").document(currentUser)
        
        docRef.addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                if snapshot != nil {
                    self.mailText.text=snapshot?.get("email") as? String
                    self.adSoyadText.text=snapshot?.get("isim") as? String
                    self.telNoText.text=snapshot?.get("telNo") as? String
                    self.cuzdanAdresText.text=snapshot?.get("cuzdanAdres") as? String
                    self.adresText.text=snapshot?.get("adres") as? String
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
