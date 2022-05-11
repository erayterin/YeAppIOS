//
//  AnasayfaViewController.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit

class AnasayfaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var kategoriCollectionView: UICollectionView!
    @IBOutlet weak var urunCollectionView: UICollectionView!
    
    let kategoriCell = "kategoriCell"
    let urunCell = "urunCell"
    
    var urunImg = ["hamburger","hamburger","hamburger"]
    var urunName = ["Hamburger","Pizza","Tavuk"]
    
    
   
    
    // Collection için
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.kategoriCollectionView{
            return kategoriUrunler.count
        }
        else if collectionView == self.urunCollectionView{
            return urunImg.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.kategoriCollectionView{
            let kategoriCell = collectionView.dequeueReusableCell(withReuseIdentifier: "kategoriCell", for: indexPath) as! KategoriCollectionViewCell
            
            kategoriCell.kategoriUrunImage.image = UIImage(named: kategoriUrunler[indexPath.row])
            //kategoriCell.kategoriUrunImage.layer.cornerRadius = 50.0
            kategoriCell.kategoriUrunIsim.text = kategoriUrunlerIsim[indexPath.row]
            return kategoriCell
        }
        else if collectionView == self.urunCollectionView{
            let urunCell = collectionView.dequeueReusableCell(withReuseIdentifier: "urunCell", for: indexPath) as! UrunCollectionViewCell
            
            urunCell.urunImg.image = UIImage(named: urunImg[indexPath.row])
            
            urunCell.urunName.text = urunName[indexPath.row]
            
            urunCell.index = indexPath
            
            urunCell.delegate = self
            return urunCell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*let sepetVc = storyboard?.instantiateViewController(identifier: "sepetimViewController") as? SepetimViewController
        
        sepetVc?.urunNameTxt = urunName[indexPath.row]
        sepetVc?.urunImgTxt = urunImg[indexPath.row]
        self.navigationController?.pushViewController(sepetVc!, animated: true)*/
    }
    
    //var kategoriUrunler:[String] = ["hamburger","pizza","chicken","drink","meat","patato"]
    var kategoriUrunler:[String] = ["hamburger","hamburger","hamburger","hamburger","hamburger","hamburger"]
    var kategoriUrunlerIsim:[String] = ["Hamburger","Pizza","Tavuk","İçecek","Et","Patates"]
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        kategoriCollectionView.delegate = self
        kategoriCollectionView.dataSource = self
        
        urunCollectionView.delegate = self
        urunCollectionView.dataSource = self
        
       
    }
}


extension AnasayfaViewController: UrunCollectionProtocol{
    func sepeteEkle(index: Int) {
        let sepetVc = storyboard?.instantiateViewController(identifier: "sepetimViewController") as? SepetimViewController
        
        sepetVc?.urunNameTxt = urunName[index]
        sepetVc?.urunImgTxt = urunImg[index]
        self.navigationController?.pushViewController(sepetVc!, animated: true)
    }
    
    
}
