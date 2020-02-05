//
//  SearchViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/4/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import BEMCheckBox

class SearchViewController: UIViewController {
    
    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var popupView: UIView!{
        didSet{
            popupView.layer.cornerRadius = 25
            popupView.clipsToBounds = true
        }
    }
    @IBOutlet weak var catChk: BEMCheckBox!
    @IBOutlet weak var productChk: BEMCheckBox!
    @IBOutlet weak var searchBarTf: DesignableUITextField!
    @IBOutlet weak var searchBtn: CusstomButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabToClosePopup))
        bigView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func tabToClosePopup()  {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func chkSearchFliter(_ sender: BEMCheckBox) {
    }
    
    @IBAction func searchBtnPressed(_ sender: UIButton) {
    }
}
