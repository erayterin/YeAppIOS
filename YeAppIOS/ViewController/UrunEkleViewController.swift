//
//  UrunEkleViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import FirebaseStorage
import Firebase

class UrunEkleViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    
    @IBOutlet weak var urunEkleBtn: UIButton!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var urunImage: UIImageView!
    @IBOutlet weak var urunAdText: UITextField!
    @IBOutlet weak var urunFiyatText: UITextField!
    var list = [String]()
    let db=Firestore.firestore()
    override func viewDidLoad() {
        super.viewDidLoad()

        urunEkleBtn.layer.cornerRadius=15
        urunEkleBtn.layer.masksToBounds=true
        getKategori()
        urunImage.isUserInteractionEnabled = true
        let gestureRecognizer=UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        urunImage.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func gorselSec(){
        let pickerController = UIImagePickerController()
        pickerController.delegate=self
        pickerController.sourceType = .photoLibrary
        present(pickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        urunImage.image=info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    

        public func numberOfComponents(in pickerView: UIPickerView) -> Int{
            return 1
        }

        public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

            return list.count
        }

        func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

            self.view.endEditing(true)
            return list[row]
        }

        func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

            self.textBox.text = self.list[row]
            self.dropDown.isHidden = true
        }

        func textFieldDidBeginEditing(_ textField: UITextField) {

            if textField == self.textBox {
                self.dropDown.isHidden = false
                textField.endEditing(true)
            }
        }
    
    
   
    @IBAction func urunEkle(_ sender: Any) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        let mediaFolder=storageReferance.child("media")
        if let data = self.urunImage.image?.jpegData(compressionQuality: 0.5){
            let uuId = UUID().uuidString
            let imageReferance = mediaFolder.child("\(uuId).jpg")
            imageReferance.putData(data, metadata: nil) { (storagemetadata, error) in
                if error != nil {
                    print(error?.localizedDescription)
                }else{
                    imageReferance.downloadURL { (url, error) in
                        if error == nil {
                            let imageUrl=url?.absoluteString
                            if let imageUrl = imageUrl {
                                self.urunCreate(imageUrl: imageUrl , kategoriAdi: self.textBox.text!)
                                self.hataMesaji(titleInput: "Başarılı", messageInput: "Urun eklendi.")
                            }
                        }
                    }
                }
            }
        }
    }
    
    func urunCreate(imageUrl : String , kategoriAdi : String){
        let currentUser = Auth.auth().currentUser!.uid
        
        let firestoreUser = ["imageUrl" : imageUrl , "kategoriAdi" : kategoriAdi, "id" : "" , "urunAdi" : urunAdText.text!,"urunFiyat" : urunFiyatText.text!]
        
        Firestore.firestore().collection("Urunler").document().setData(firestoreUser){
            (error) in
            if error != nil{
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                
            }
        }
    }
    
    func getKategori(){
        db.collection("Kategoriler").addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                for document in snapshot!.documents{
                    if let kategoriAd = document.get("kategoriAdi") as? String{
                        self.list.append(kategoriAd)
                        self.textBox.text=self.list.first
                        self.dropDown.reloadAllComponents()
                    }
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
