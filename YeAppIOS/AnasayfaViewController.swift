//
//  AnasayfaViewController.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit

class AnasayfaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    
    @IBOutlet weak var urunTableView: UITableView!
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        kategoriUrunler.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let kategoriCell = collectionView.dequeueReusableCell(withReuseIdentifier: "kategoricell", for: indexPath) as! KategoriCollectionViewCell
        
        kategoriCell.kategoriUrunImage.image = UIImage(named: kategoriUrunler[indexPath.row])
        //kategoriCell.kategoriUrunImage.layer.cornerRadius = 50.0
        kategoriCell.kategoriUrunIsim.text = kategoriUrunlerIsim[indexPath.row]
        return kategoriCell
    }
    
    //var kategoriUrunler:[String] = ["hamburger","pizza","chicken","drink","meat","patato"]
    var kategoriUrunler:[String] = ["hamburger","hamburger","hamburger","hamburger","hamburger","hamburger"]
    var kategoriUrunlerIsim:[String] = ["Hamburger","Pizza","Tavuk","İçecek","Et","Patates"]
    
    
    var listUrunler = [UrunData]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Urunleri ekliyoruz
        let urun1 = UrunData(urunName: "Hamburger", urunImage: "hamburger")
        listUrunler.append(urun1)
        let urun2 = UrunData(urunName: "Pizza", urunImage: "hamburger")
        listUrunler.append(urun2)
        let urun3 = UrunData(urunName: "Tavuk", urunImage: "hamburger")
        listUrunler.append(urun3)
        
        
        
        urunTableView.tableFooterView = UIView(frame: .zero)
       
    }
}

extension AnasayfaViewController:UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listUrunler.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let urunTableCell = urunTableView.dequeueReusableCell(withIdentifier: "urunTableCell", for: indexPath) as! UrunTableViewCell
        urunTableCell.urunNameLabel.text = listUrunler[indexPath.row].urunName
        urunTableCell.urunImage.image = UIImage(named: listUrunler[indexPath.row].urunImage)
        
        // Sepete Ekle Buton Yuvarlak
        urunTableCell.sepeteEkleBtn.layer.cornerRadius=15
        urunTableCell.sepeteEkleBtn.layer.masksToBounds=true
        return urunTableCell
    }
    
    
}
