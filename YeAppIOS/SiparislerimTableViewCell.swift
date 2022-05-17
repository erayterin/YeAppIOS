//
//  SiparislerimTableViewCell.swift
//  YeAppIOS
//
//  Created by bigsur on 17.05.2022.
//

import UIKit

class SiparislerimTableViewCell: UITableViewCell {

    @IBOutlet weak var siparisUrunImg: UIImageView!
    @IBOutlet weak var siparisUrunTarih: UILabel!
    @IBOutlet weak var siparisId: UILabel!
    @IBOutlet weak var siparisDetaylar: UILabel!
    @IBOutlet weak var siparisToplamFiyat: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
