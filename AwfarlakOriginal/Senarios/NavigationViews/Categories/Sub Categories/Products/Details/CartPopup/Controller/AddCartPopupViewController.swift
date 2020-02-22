//
//  AddCartPopupViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH
class AddCartPopupViewController: UIViewController {
    
    //MARK: - Variables
    
    var productDetails : ProductDetails?
    var quantity : Int = 1
    
    //MARK: - IBOutlet
    
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
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var quantityView: UIView!{
        didSet{
            quantityView.layer.cornerRadius = quantityView.frame.size.height / 2
            quantityView.clipsToBounds = true
        }
    }
    @IBOutlet weak var viewOfAppIcon: UIView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var quantityLbl: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewDesign()
        getProductDescription()
        
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
        chkDesignBtn()
    }
    
    
    
    func chkDesignBtn()  {
        if MOLHLanguage.currentAppleLanguage() == "en"{
            productPrice.layer.cornerRadius = productPrice.frame.size.height / 2
            productPrice.clipsToBounds = true
            productPrice.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            productPrice.layer.cornerRadius = productPrice.frame.size.height / 2
            productPrice.clipsToBounds = true
            productPrice.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
            
        }
        
    }
    
    //MARK: - Func to Get Product Description
    
    func getProductDescription()  {
        if let idProduct = ProductDetailsViewController.idProduct {
            Services.getProductDetails(idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.productDetails = result
                    self.updateDesign()
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Func to  Update Design
    
    func updateDesign()  {
        self.productDescription.text = self.productDetails?.productDetailsDescription
        self.productPrice.attributedText = NSAttributedString.withDualText(text1: "Rs".localized, ofSizeText1: 20, text2: productDetails!.priceAfterDiscount, ofSizeText2: 20)
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
