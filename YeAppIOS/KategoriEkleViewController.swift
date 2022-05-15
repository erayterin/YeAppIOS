//
//  KategoriEkleViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import FirebaseStorage
import Firebase

class KategoriEkleViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate {

    @IBOutlet weak var kategoriEkleBtn: UIButton!
    @IBOutlet weak var onImage: UIImageView!
    @IBOutlet weak var arkaImage: UIImageView!
    @IBOutlet weak var kategoriAdText: UITextField!
    var onSecili = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        kategoriEkleBtn.layer.cornerRadius=25
        kategoriEkleBtn.layer.masksToBounds=true
        
        onImage.isUserInteractionEnabled = true
        let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(onGorselSec))
        onImage.addGestureRecognizer(gestureRecognizer)
        arkaImage.isUserInteractionEnabled=true
        let arkaGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(arkaGorselSec))
        arkaImage.addGestureRecognizer(arkaGestureRecognizer)
    }
    
    @objc func onGorselSec(){
        onSecili = true
        let pickerController = UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    @objc func arkaGorselSec(){
        onSecili=false
        let pickerController = UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if onSecili {
            onImage.image=info[.originalImage] as? UIImage
        }else{
            arkaImage.image=info[.originalImage] as? UIImage
        }
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func kategoriEkle(_ sender: Any) {
        
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder=storageReferance.child("media")
        if let onData = onImage.image?.jpegData(compressionQuality: 0.5){
            let uuId = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuId).jpg")
            imageReferance.putData(onData, metadata: nil) { (storagemetadata, error) in
                if error != nil {
                    print(error?.localizedDescription)
                }else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl=url?.absoluteString
                            if let imageUrl = imageUrl {
                                if let arkaData = self.arkaImage.image?.jpegData(compressionQuality: 0.5){
                                    let uuId = UUID().uuidString
                                    let imageReferance = mediaFolder.child("\(uuId).jpg")
                                    imageReferance.putData(arkaData, metadata: nil) { (storagemetadata, error) in
                                        if error != nil {
                                            print(error?.localizedDescription)
                                        }else{
                                            imageReferance.downloadURL { (url, error) in
                                                if error == nil {
                                                    let imageUrl2=url?.absoluteString
                                                    if let imageUrl2 = imageUrl2 {
                                                        self.kategoriCreate(onUrl: imageUrl, arkaUrl: imageUrl2, kategoriAdi: self.kategoriAdText.text!)
                                                        self.hataMesaji(titleInput: "Başarılı", messageInput: "Kategori eklendi.")
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                                
                            }
                            
                        }
                    }
                }
            }
        }
        
    }
    
    func kategoriCreate(onUrl : String , arkaUrl : String , kategoriAdi : String){
        let currentUser = Auth.auth().currentUser!.uid
        
        let firestoreUser = ["onUrl" : onUrl , "arkaUrl" : arkaUrl , "kategoriAdi" : kategoriAdi, "id" : ""]
        
        Firestore.firestore().collection("Kategoriler").document().setData(firestoreUser){
            (error) in
            if error != nil{
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                
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
