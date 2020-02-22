//
//  AddRateViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/4/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

class AddRateViewController: UIViewController {
    
    //MARK: - Variables
    
    var idProduct : String?
    var addRateToProduct : AddRateToProduct?
    
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var popupView: UIView!{
        didSet{
            popupView.layer.cornerRadius = 25
            popupView.clipsToBounds = true
        }
    }
    @IBOutlet weak var addRate: CosmosView!
    @IBOutlet weak var submitBtn: CusstomButton!
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabToClosePopup))
        bigView.addGestureRecognizer(tapGesture)
    }
    
    //MARK: - Func To Dismiss Popup

    @objc func tabToClosePopup()  {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Func to Add Rate To Product
       
       func addRateUserToProduct()  {
        if let idProduct = idProduct , Int(addRate.rating) != nil {
            Services.addRate(idUser: UserDefault.getId(), idProduct: idProduct, rateNumber: Int(addRate.rating), callback: { (result) in
                   print(result)
                   switch result.status {
                   case 1:
                    Alert.show("Success".localized, massege: "Rat".localized, context: self)
                   case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                   default:
                    print(result.status ?? "")
                   }
               }) { (error) in
                   print(error.localizedDescription)
               }
           }
       }
    
    //MARK: - IBAction

    @IBAction func submitBtnPressed(_ sender: UIButton) {
        addRateUserToProduct()
    }
    
}
