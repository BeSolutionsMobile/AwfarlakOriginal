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
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var popupView: UIView!{
        didSet{
            popupView.layer.cornerRadius = 25
            popupView.clipsToBounds = true
        }
    }
    @IBOutlet weak var addRate: CosmosView!
    @IBOutlet weak var submitBtn: CusstomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabToClosePopup))
        bigView.addGestureRecognizer(tapGesture)
    }
    @objc func tabToClosePopup()  {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func submitBtnPressed(_ sender: UIButton) {
    }
    
}
