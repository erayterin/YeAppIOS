//
//  AnasayfaViewController.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit

class AnasayfaViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
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
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
    


}
