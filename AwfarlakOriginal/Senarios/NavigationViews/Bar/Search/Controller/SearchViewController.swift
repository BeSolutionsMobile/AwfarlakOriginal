//
//  SearchViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/4/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import BEMCheckBox

//MARK: - Insert New Protocal Named SearchProductDelegate

protocol SearchProductDelegate {
    func transferResultProduct( text : String)
}


class SearchViewController: UIViewController {
    
    //MARK: - Variables

    var d : SearchProductDelegate?

    //MARK: - IBOutlet

    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var popupView: UIView!{
        didSet{
            popupView.layer.cornerRadius = 25
            popupView.clipsToBounds = true
        }
    }
    @IBOutlet weak var searchBarTf: DesignableUITextField!
    @IBOutlet weak var searchhBtn: CusstomButton!
    //
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabToClosePopup))
        bigView.addGestureRecognizer(tapGesture)
        // Do any additional setup after loading the view.
    }
    
    
    @objc func tabToClosePopup()  {
        dismiss(animated: true, completion: nil)
    }
    
    
    //MARK: - IBOutlet

    @IBAction func searchBtnPressed(_ sender: UIButton) {
        d?.transferResultProduct(text: searchBarTf.text ?? "")
        dismiss(animated: true, completion: nil)
        
    }
}
