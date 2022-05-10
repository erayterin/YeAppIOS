//
//  UrunGuncelleViewController.swift
//  YeAppIOS
//
//  Created by ynssasa on 9.05.2022.
//

import UIKit

class UrunGuncelleViewController: UIViewController , UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {

    @IBOutlet weak var urunGuncelleBtn: UIButton!
    @IBOutlet weak var textBox: UITextField!
    @IBOutlet weak var dropDown: UIPickerView!
    var list = ["Hamburger1", "Hamburger2", "Hamburger3","Hamburger4","Hamburger5"]
    override func viewDidLoad() {
        super.viewDidLoad()
        urunGuncelleBtn.layer.cornerRadius=15
        urunGuncelleBtn.layer.masksToBounds=true
    }
    
    public func numberOfComponents(in pickerView: UIPickerView) -> Int{
        return 1
    }

    public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{

        return list.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {

        self.view.endEditing(true)
        return list[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {

        self.textBox.text = self.list[row]
        self.dropDown.isHidden = true
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {

        if textField == self.textBox {
            self.dropDown.isHidden = false
            //if you don't want the users to se the keyboard type:

            textField.endEditing(true)
        }
    }

}
