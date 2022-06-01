//
//  UrunSilViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import Firebase

class UrunSilViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var urunSilBtn: UIButton!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    let currentUser=Auth.auth().currentUser!.uid
    let db=Firestore.firestore()
    var list = [String]()
    var idList = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        urunSilBtn.layer.cornerRadius=15
        urunSilBtn.layer.masksToBounds=true
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
        self.dropDown.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textBox {
            self.dropDown.isHidden = false
            textField.endEditing(true)
        }
    }

    @IBAction func urunSil(_ sender: Any) {
        let row = getUrunIndex()
        db.collection("Urunler").document(idList[row]).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                self.idList.removeAll()
                self.list.removeAll()
                self.getUrun()
                print("Document successfully removed!")
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
                    if let urunAd = document.get("urunAdi") as? String{
                        self.list.append(urunAd)
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
