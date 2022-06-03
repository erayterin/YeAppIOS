//
//  AnasayfaViewController.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit
import Firebase
import SDWebImage

class AnasayfaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    @IBOutlet weak var urunCollectionView: UICollectionView!
    
    let kategoriCell = "kategoriCell"
    let urunCell = "urunCell"
    
    var urunImg = [String]()
    var urunName = [String]()
    var urunFiyat = [String]()
    var urunKategoriAdi = [String]()
    
    let db=Firestore.firestore()
    let currentUser=Auth.auth().currentUser!.uid
    
    var kategoriUrunlerIsim = [String]()
    var kategoriOnResim = [String]()
    var kategoriArkaResim = [String]()
    
    var secili = 0
    
    
    func getKategori(){
        db.collection("Kategoriler").addSnapshotListener { [self] (snapshot, error) in
            if error != nil {
                print("kategori hata")
            }else{
                for document in snapshot!.documents{
                    if let kategoriAd = document.get("kategoriAdi") as? String{
                        self.kategoriUrunlerIsim.append(kategoriAd)
                        self.kategoriCollectionView.reloadData()
                    }
                    if let arkaResim = document.get("onUrl") as? String{
                        self.kategoriArkaResim.append(arkaResim)
                    }
                    if let onResim = document.get("arkaUrl") as? String{
                        self.kategoriOnResim.append(onResim)
                    }
                }
            }
        }
        
    }
    
    // Collection için
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.kategoriCollectionView{
            return kategoriUrunlerIsim.count
        }
        else if collectionView == self.urunCollectionView{
            return urunImg.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.kategoriCollectionView{
            let kategoriCell = collectionView.dequeueReusableCell(withReuseIdentifier: "kategoriCell", for: indexPath) as! KategoriCollectionViewCell
            kategoriCell.delegate = self
            kategoriCell.index = indexPath
            
            if secili != indexPath.row {
                kategoriCell.kategoriUrunImage.sd_setImage(with: URL(string: self.kategoriOnResim[indexPath.row]), for: UIControl.State.normal)
            }else{
                kategoriCell.kategoriUrunImage.sd_setImage(with: URL(string: self.kategoriArkaResim[indexPath.row]), for: UIControl.State.normal)
            }
            
            kategoriCell.kategoriUrunIsim.text = kategoriUrunlerIsim[indexPath.row]
            
            
            return kategoriCell
        }
        else if collectionView == self.urunCollectionView{
            let urunCell = collectionView.dequeueReusableCell(withReuseIdentifier: "urunCell", for: indexPath) as! UrunCollectionViewCell
            
            urunCell.urunImg.sd_setImage(with: URL(string: self.urunImg[indexPath.row]))
            urunCell.urunName.text = self.urunName[indexPath.row]
            urunCell.urunPrice.text = self.urunFiyat[indexPath.row]
        
            return urunCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        kategoriCollectionView.delegate = self
        kategoriCollectionView.dataSource = self
        
        urunCollectionView.delegate = self
        urunCollectionView.dataSource = self
        
        self.kategoriUrunlerIsim.removeAll()
        self.urunImg.removeAll()
        self.urunName.removeAll()
        self.urunFiyat.removeAll()
        self.getKategori()
        self.getUrun(kategoriUrunIsim: kategoriUrunlerIsim.first ?? "Hamburger")
        //self.getUrun2(kategoriUrunIsim: "Tavuk")
        
        kategoriCollectionView.reloadData()
        
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if secili == 0{
            if let kategoriUrunIsim = self.kategoriUrunlerIsim.first{
                self.getUrun(kategoriUrunIsim: kategoriUrunIsim)
            }
        }
        else{
            
            self.getUrun(kategoriUrunIsim: self.kategoriUrunlerIsim[secili])
            
        }
        
                
    }
}


extension AnasayfaViewController:KategoriCollectionProtocol{
    func tikla(index : Int) {
        secili = index
        kategoriCollectionView.reloadData()
    }
    
    func getUrun(kategoriUrunIsim: String) {
        
        self.urunImg.removeAll()
        self.urunName.removeAll()
        self.urunFiyat.removeAll()
        db.collection("Urunler").addSnapshotListener { (snapshot, error) in
            if error != nil {
                print("Hata Urunler")
            }else{
                for document in snapshot!.documents{
                    if let urunKategoriAdi=document.get("kategoriAdi") as? String{
                        if urunKategoriAdi == kategoriUrunIsim{
                            if let urunAdi = document.get("urunAdi") as? String{
                                self.urunName.append(urunAdi)
                            }
                            if let urunImageUrl=document.get("imageUrl") as? String{
                                self.urunImg.append(urunImageUrl)
                            }
                            if let urunFiyat=document.get("urunFiyat") as? String{
                                self.urunFiyat.append(urunFiyat)
                            }
                            self.urunKategoriAdi.append(urunKategoriAdi)
                            self.urunCollectionView.reloadData()
                        }
                    }
                }
            }
        }
    }
    
    
    
    
}

