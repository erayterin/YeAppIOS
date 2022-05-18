//
//  UyeOlViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import Firebase
class UyeOlViewController: UIViewController {

    @IBOutlet weak var uyeOlBtn: UIButton!
    @IBOutlet weak var emailTxt: UITextField!
    @IBOutlet weak var sifreText: UITextField!
    @IBOutlet weak var sifreTekrarText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        uyeOlBtn.layer.cornerRadius=25
        uyeOlBtn.layer.masksToBounds=true
        
        sifreText.isSecureTextEntry=true
        sifreTekrarText.isSecureTextEntry=true
    }
    
    @IBAction func uyeOl(_ sender: Any) {
        if emailTxt.text != "" && sifreText.text != "" && sifreTekrarText.text != ""{
            if sifreText.text!.elementsEqual(sifreTekrarText.text!){
                Auth.auth().createUser(withEmail: emailTxt.text!, password: sifreText.text!) { [self] (authdataresult, error) in
                    if error != nil{
                        self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
                    }else{
                        userAdd()
                        self.performSegue(withIdentifier: "toGirisYap", sender: nil)
                    }
                }
            }else{
                self.hataMesaji(titleInput: "Hata", messageInput: "Şifreleriniz uyuşmuyor.")
            }
        }else{
            hataMesaji(titleInput: "Hata", messageInput: "Email ve Parolayı doğru giriniz.")
        }
    }
    
    func hataMesaji(titleInput: String,messageInput: String){
        let alert = UIAlertController(title: titleInput, message: messageInput, preferredStyle: UIAlertController.Style.alert)
        let  okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil)
        alert.addAction(okButton)
        self.present(alert, animated: true, completion: nil)
    }
    
    func userAdd(){
        let currentUser = Auth.auth().currentUser!.uid
        
        let firestoreUser = ["adres" : "" , "cuzdanAdres" : "" , "email" : emailTxt.text! , "id" : currentUser , "isim" : "" , "sifre" : sifreText.text! , "telNo" : "" ]
        
        Firestore.firestore().collection("Users").document(currentUser).setData(firestoreUser){
            (error) in
            if error != nil{
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                
            }
        }
    }
        
    
}
