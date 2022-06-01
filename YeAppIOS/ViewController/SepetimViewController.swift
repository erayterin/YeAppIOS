//
//  SepetimViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 10.05.2022.
//

import UIKit

class SepetimViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var sepetUrunCollectionView: UICollectionView!
    
    
    @IBOutlet weak var urunImg: UIImageView!
    @IBOutlet weak var urunName: UILabel!
    @IBOutlet weak var urunCount: UILabel!
    @IBOutlet weak var urunPrice: UILabel!
    @IBOutlet weak var urunSilImg: UIImageView!
    
    @IBOutlet weak var araToplamTxt: UILabel!
    @IBOutlet weak var odemeYapBtn: UIButton!
    
    @IBOutlet weak var teslimatUcretiTxt: UILabel!
    
    @IBOutlet weak var toplamUcretTxt: UILabel!
    //var urunnImg = ["hamburger","hamburger","hamburger"]
    //var urunnName = ["Hamburger","Pizza","Tavuk"]
    
    
    @IBAction func odemeYapBtn(_ sender: Any) {
        performSegue(withIdentifier: "toOdemeYap", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toOdemeYap"{
            let destinationVC = segue.destination as! OdemeYapViewController
            destinationVC.araToplamText = araToplamTxt.text!
            //destinationVC.teslimatUcretiText = teslimatUcretiTxt.text!
            destinationVC.toplamText = toplamUcretTxt.text!
        }
    }
    func sepetHesapla(){
        
        if(Sepet.sepet.sepetHesapla()>0){
            araToplamTxt.text = (Sepet.sepet.sepetHesapla() - Sepet.sepet.teslimatUcreti).description+" ₺"
        }
        else{
            araToplamTxt.text = "0 ₺"
        }
        
        teslimatUcretiTxt.text = Sepet.sepet.teslimatUcreti.description+" ₺"
        if (araToplamTxt.text as! NSString).integerValue != 0 {
            toplamUcretTxt.text = (Sepet.sepet.sepetHesapla()).description+" ₺"
        }
        else{
            toplamUcretTxt.text = "0 ₺"
        }
        
        
        
        
        
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sepetUrunCollectionView.delegate = self
        sepetUrunCollectionView.dataSource = self
        
        
        odemeYapBtn.layer.cornerRadius=15
        odemeYapBtn.layer.masksToBounds=true
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        sepetHesapla()
        self.loadCollectionData()
                
    }
    func loadCollectionData() {
        // code to load data from network, and refresh the interface
        sepetUrunCollectionView.reloadData()
    }
    // Collection için
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.sepetUrunCollectionView{
            return Sepet.sepet.urunSepetList.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.sepetUrunCollectionView{
            let sepetUrunCell = collectionView.dequeueReusableCell(withReuseIdentifier: "sepetUrunCell", for: indexPath) as! SepetCollectionViewCell
            
            sepetUrunCell.sepetUrunImg.image = Sepet.sepet.urunSepetList[indexPath.row].urunImg
            sepetUrunCell.sepetUrunName.text = Sepet.sepet.urunSepetList[indexPath.row].urunName
           
            sepetUrunCell.sepetUrunCount.text = Sepet.sepet.urunSepetList[indexPath.row].urunCount
            
            sepetUrunCell.sepetUrunPrice.text = Sepet.sepet.urunSepetList[indexPath.row].urunPrice
            
            sepetUrunCell.index = indexPath
            sepetUrunCell.delegate = self
            
            return sepetUrunCell
        }
        
        return UICollectionViewCell()

    }
    
    
}

extension SepetimViewController:SepetCollectionProtocol{
    func sepetUrunArttir() {
       sepetHesapla()
        
    }
    func sepetUrunAzalt() {
        sepetHesapla()
    }
    func sepetUrunSil(index: Int) {
        Sepet.sepet.urunSepetList.remove(at: index)
        sepetHesapla()
        self.loadCollectionData()
    }
    
    
    
}
