//
//  AddCartPopupViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class AddCartPopupViewController: UIViewController {
    
    var quantity : Int = 1

    @IBOutlet weak var bigView: UIView!
    @IBOutlet weak var popupView: UIView!{
        didSet{
            popupView.layer.cornerRadius = 25
            popupView.clipsToBounds = true
        }
    }
    @IBOutlet weak var viewOfImage: UIView!{
        didSet{
            viewOfImage.layer.cornerRadius = self.viewOfImage.frame.height/2
            viewOfImage.layer.borderWidth = 1
            viewOfImage.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.6235294118, blue: 0.09803921569, alpha: 1)
            
            
        }
    }
    @IBOutlet weak var popupImage: UIImageView!
    @IBOutlet weak var productDetails: UILabel!
    @IBOutlet weak var quantityView: UIView!{
        didSet{
           quantityView.layer.cornerRadius = quantityView.frame.size.height / 2
           quantityView.clipsToBounds = true
        }
    }
    @IBOutlet weak var viewOfAppIcon: UIView!
    @IBOutlet weak var productPrice: UILabel!{
        didSet{
           productPrice.layer.cornerRadius = productPrice.frame.size.height / 2
           productPrice.clipsToBounds = true
           productPrice.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
        }
    }
    @IBOutlet weak var quantityLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewDesign()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabToClosePopup))
        bigView.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    @objc func tabToClosePopup()  {
        dismiss(animated: true, completion: nil)
    }
    
    
    func updateViewDesign() {
        
        CustomDesign.customCircleImage(image: popupImage)
        CustomDesign.cricleViewDesign(view: viewOfAppIcon)
    }
    
    
    @IBAction func addQuantityBtnPressed(_ sender: UIButton) {
        quantity = quantity + 1
        quantityLbl.text = String(quantity)
    }
    
    @IBAction func minusQuantityBtnPressed(_ sender: UIButton) {
        if quantity == 1 {
            quantityLbl.text = String(quantity)
        }else {
            quantity = quantity - 1
            quantityLbl.text = String(quantity)
        }
    }
    
}
