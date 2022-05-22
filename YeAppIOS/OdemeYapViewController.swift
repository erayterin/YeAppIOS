//
//  OdemeYapViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit
import Firebase

class OdemeYapViewController: UIViewController {

    @IBOutlet weak var araToplamTxt: UILabel!
    @IBOutlet weak var teslimatUcretiTxt: UILabel!
    @IBOutlet weak var toplamTxt: UILabel!
    
    @IBOutlet weak var adresText: UITextView!
    @IBOutlet weak var odemeBtn: UIButton!
    @IBOutlet weak var kapidaBtn: UIButton!
    @IBOutlet weak var TRXBtn: UIButton!
    @IBOutlet weak var cuzdanKoduText: UILabel!
    @IBOutlet weak var copyBtn: UIButton!
    var odemeTipi = "Kapıda Ödeme"
    var urunImageList = [String]()
    
    
    
    let currentUser=Auth.auth().currentUser!.uid
    let db=Firestore.firestore()
    
    var odemeSekli = true
    
    
    var araToplamText = "0"
    var toplamText = "0"
    
    var ownerAdress = "TBA6CypYJizwA9XdC7Ubgc5F1bxrQ7SqPt" //musteri adresi gonderen
    var toAdress = "T9zzBDkYdrckB7BVHpHnc18brUBFof4PGy" // dukkan adresi
    var urunTutari:Double = 163510320 / 1000000
    var islemBool : Bool = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        odemeBtn.layer.cornerRadius=15
        odemeBtn.layer.masksToBounds=true
        getAdres()
        self.adresText.isEditable=false
        
        
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        araToplamTxt.text = araToplamText
        teslimatUcretiTxt.text = Sepet.sepet.teslimatUcreti.description
        toplamTxt.text = toplamText
    }
    
    
    @IBAction func clickKapida(_ sender: Any) {
        odemeSekli=true
        odemeTipi = "Kapıda Ödeme"
        kapidaBtn.setImage(UIImage(named: "dolu"), for: .normal)
        TRXBtn.setImage(UIImage(named: "bos"), for: .normal)
    }
    
    
    @IBAction func clickTRX(_ sender: Any) {
        odemeSekli=false
        odemeTipi = "Kripto Ödeme"
        TRXBtn.setImage(UIImage(named: "dolu"), for: .normal)
        kapidaBtn.setImage(UIImage(named: "bos"), for: .normal)
    }
    
    
    @IBAction func clickCopy(_ sender: Any) {
        copyBtn.setImage(UIImage(named: "turuncutick"), for: .normal)
        
        UIPasteboard.general.string = cuzdanKoduText.text
    }
    
    
    @IBAction func odemeKontrolBtn(_ sender: Any) {
        if odemeSekli == true {
            self.performSegue(withIdentifier: "toSiparisOnayla", sender: nil)
            siparisCreate()
            Sepet.sepet.urunSepetList.removeAll()
        }else{
            coinKontrol()
        }
        
    }
    
    func coinKontrol(){
        let url = URL(string: "https://apilist.tronscan.org/api/transaction?sort=-timestamp&count=true&limit=20&start=0&address=T9zzBDkYdrckB7BVHpHnc18brUBFof4PGy")
        
        WebService().getTrxApi(url: url!) { (trxDataList) in
            if let trxDataList = trxDataList{
                
                //Kontrol
                let gonderen = trxDataList.data[1].contractData.owner_address
                let alici = trxDataList.data[1].contractData.to_address
                let amount = Double(trxDataList.data[1].contractData.amount)/1000000
                // Main Thread'e dahil etme
                DispatchQueue.main.async {
                    if ((gonderen.elementsEqual(self.ownerAdress)) && (alici.elementsEqual(self.toAdress)) && (amount == self.urunTutari)) {
                        self.performSegue(withIdentifier: "toSiparisOnayla", sender: nil)
                        self.siparisCreate()
                        Sepet.sepet.urunSepetList.removeAll()
                    }
                    else{
                        print("islem bool : ",self.islemBool)
                        print("error islem bool")
                        self.performSegue(withIdentifier: "toSiparisOnayHata", sender: nil)
                    }
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
                    self.adresText.text=snapshot?.get("adres") as? String
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
    
    func siparisCreate(){
        let currentUser = Auth.auth().currentUser!.uid
        
        let firestoreSiparis = ["adres" : adresText.text! , "date" : nowDate(), "id" : "" , "odemeTipi" : odemeTipi,"toplam" : Sepet.sepet.sepetHesapla().description]
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("Siparisler").document(currentUser).collection("Siparis").document()
        print(ref!.documentID)
        self.siparisDetayCreate(id: ref!.documentID)
        self.adminSiparisDetayCreate(id: ref!.documentID)
        ref!.setData(firestoreSiparis){
            (error) in
            if error != nil{
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                
            }
        }
    }
    
    func adminSiparisDetayCreate(id : String){
        let currentUser = Auth.auth().currentUser!.uid
        let firestoreSiparis = ["userId" : currentUser , "toplam" : Sepet.sepet.sepetHesapla().description , "adres" : adresText.text!,"date" : self.nowDate()]
        var ref: DocumentReference? = nil
        ref = Firestore.firestore().collection("AdminSiparisDetay").document(id)
        ref!.setData(firestoreSiparis){
            (error) in
            if error != nil{
                self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
            }else{
                
            }
        }
     
    }
    
    
    func siparisDetayCreate(id : String){
        let currentUser = Auth.auth().currentUser!.uid
        var ref: DocumentReference? = nil
        for sepetUrun in Sepet.sepet.urunSepetList{
            db.collection("Urunler").addSnapshotListener { (snapshot, error) in
                if error != nil {
                    print("Hata Urunler")
                   
                }else{
                    for document in snapshot!.documents{
                        if let urunAdi=document.get("urunAdi") as? String{
                            if urunAdi == sepetUrun.urunName{
                                
                                if let urunImageUrl=document.get("imageUrl") as? String{
                                    let firestoreSiparis = ["adet" : sepetUrun.urunCount , "date" : self.nowDate(), "resim" : urunImageUrl , "urunAd" : sepetUrun.urunName,"urunFiyat" : sepetUrun.urunPrice,"userId":currentUser] as [String : Any]
                                    
                                    ref = Firestore.firestore().collection("SiparisDetay").document(id).collection("Urunler").document()
                                    ref!.setData(firestoreSiparis){
                                        (error) in
                                        if error != nil{
                                            self.hataMesaji(titleInput: "HATA", messageInput: error?.localizedDescription ?? "Hata aldınız , tekrar deneyiniz.")
                                        }else{
                                            
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
