//
//  UrunGuncelleViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import Firebase

class UrunGuncelleViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var urunGuncelleBtn: UIButton!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    @IBOutlet weak var urunAdi: UITextField!
    @IBOutlet weak var urunFiyat: UITextField!
    var list = [String]()
    var fiyatList = [String]()
    var idList = [String]()
    let db=Firestore.firestore()
    let currentUser=Auth.auth().currentUser!.uid
    override func viewDidLoad() {
        super.viewDidLoad()
        urunGuncelleBtn.layer.cornerRadius=15
        urunGuncelleBtn.layer.masksToBounds=true
        getUrun()
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
        self.urunAdi.text=self.list[row]
        self.urunFiyat.text=self.fiyatList[row]
        self.dropDown.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textBox {
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
    }
    @IBAction func urunGuncelle(_ sender: Any) {
        let index=getUrunIndex()
        let firestoreUser = ["urunAdi" : urunAdi.text!, "urunFiyat" : urunFiyat.text!]
        
        Firestore.firestore().collection("Urunler").document(idList[index]).updateData(firestoreUser){
            (error) in
            if error != nil{
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                self.list.removeAll()
                self.fiyatList.removeAll()
                self.idList.removeAll()
                self.getUrun()
                self.hataMesaji(titleInput: "Başarılı", messageInput: "Güncellendi")
            }
        }
        
    }
    
    func getUrun(){
        db.collection("Urunler").addSnapshotListener { (snapshot, error) in
            if error != nil {
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                for document in snapshot!.documents{
                    self.idList.append(document.documentID)
                    if let urunAdi = document.get("urunAdi") as? String{
                        self.list.append(urunAdi)
                        self.textBox.text=self.list.first
                        self.urunAdi.text=self.list.first
                        self.dropDown.reloadAllComponents()
                    }
                    
                    if let urunFiyat=document.get("urunFiyat") as? String{
                        self.fiyatList.append(urunFiyat)
                        self.urunFiyat.text=self.fiyatList.first
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
    
    func getUrunIndex () -> Int {
        var sayac = 0
        for ad in list {
            sayac += 1
            if ad == textBox.text {
                return sayac-1
            }
        }
        return 0
    }

}
