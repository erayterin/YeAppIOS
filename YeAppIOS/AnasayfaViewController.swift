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
            
            kategoriCell.kategoriUrunImage.setImage(UIImage(named: "hamburger"), for: .normal)
            kategoriCell.kategoriUrunIsim.text = kategoriUrunlerIsim[indexPath.row]
            
            kategoriCell.delegate = self
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
                
        if let kategoriUrunIsim = self.kategoriUrunlerIsim.first{
            self.getUrun(kategoriUrunIsim: kategoriUrunIsim)
        }
        
        
                
    }
}


extension AnasayfaViewController:KategoriCollectionProtocol{
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

