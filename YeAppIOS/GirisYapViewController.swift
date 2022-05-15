//
//  GirisYapViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import Firebase

class GirisYapViewController: UIViewController {

    @IBOutlet weak var girisYapBtn: UIButton!
    @IBOutlet weak var emailText: UITextField!
    @IBOutlet weak var sifreText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        girisYapBtn.layer.cornerRadius=25
        girisYapBtn.layer.masksToBounds=true
        
        
    }

    @IBAction func girisYap(_ sender: Any) {
       
        
        if emailText.text != "" && sifreText.text != ""{
            Auth.auth().signIn(withEmail: emailText.text!, password: sifreText.text!) { (authdataresult, error) in
                if error != nil{
                    self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
                }else{
                    self.performSegue(withIdentifier: "toTabBar", sender: nil)
                }
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
}
