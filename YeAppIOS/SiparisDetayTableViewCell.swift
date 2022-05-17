//
//  SiparisDetayTableViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 17.05.2022.
//

import UIKit

class SiparisDetayTableViewCell: UITableViewCell {

    @IBOutlet weak var siparisDetayUrunImg: UIImageView!
    @IBOutlet weak var siparisDetayUrunFiyat: UILabel!
    @IBOutlet weak var siparisDetayUrunAdi: UILabel!
    @IBOutlet weak var siparisDetayUrunAdet: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
