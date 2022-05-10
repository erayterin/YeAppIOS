//
//  UrunTableViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 10.05.2022.
//

import UIKit

class UrunTableViewCell: UITableViewCell {

    @IBOutlet weak var urunNameLabel: UILabel!
    
    @IBOutlet weak var urunImage: UIImageView!
    
    @IBOutlet weak var urunSayiLabel: UILabel!
    
    @IBOutlet weak var urunFiyatLabel: UILabel!
    
    @IBOutlet weak var urunAzaltImage: UIImageView!
    
    @IBOutlet weak var urunArttirImage: UIImageView!
    
    @IBOutlet weak var sepeteEkleBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
