//
//  AddCartPopupViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH
import CoreData
import NVActivityIndicatorView

//MARK: - Insert New Protocal Named AddToCartAndGo

protocol AddToCartAndGo {
    func goToCart()
}
class AddCartPopupViewController: UIViewController  , NVActivityIndicatorViewable{
    
    //MARK: - Variables
    
    var productDetails : ProductDetails?
    var quantity : Int = 1
    var idProduct : String?
    var addToCartAndGo : AddToCartAndGo?
    
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
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewDesign()
        getProductDescription()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tabToClosePopup))
        bigView.addGestureRecognizer(tapGesture)
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Func to  Dismiss Popup
    
    @objc func tabToClosePopup()  {
        dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Func to  Update Design

    func updateViewDesign() {
        CustomDesign.customCircleImage(image: popupImage)
        CustomDesign.cricleViewDesign(view: viewOfAppIcon)
        chkDesignBtn()
    }
    
    //MARK: - Func to Change Design According to the Language
    
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
        if let idProduct = idProduct {
            self.startAnimating()
            Services.getProductDetails(idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.productDetails = result
                    self.updateDesign()
                    self.stopAnimating()
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                    self.stopAnimating()
                default:
                    print(result.status)
                    self.stopAnimating()
                }
            }) { (error) in
                print(error.localizedDescription)
                self.stopAnimating()
            }
        }
    }
    
    //MARK: - Func to  Update Design
    
    func updateDesign()  {
        self.productDescription.text = self.productDetails?.productDetailsDescription
        self.productPrice.attributedText = NSAttributedString.withDualText(text1: "Rs".localized, ofSizeText1: 20, text2: productDetails!.priceAfterDiscount, ofSizeText2: 20)
    }
    
    //MARK: - Func to Set Data In Core Data
    
    func setDataInCoreData() {
        if productDetails != nil {
            let newMyCart = MyCart(context: SharedCoreData.context)
            newMyCart.productimage = productDetails?.image
            newMyCart.productname =  productDetails?.title
            newMyCart.productpriceafter = productDetails?.priceAfterDiscount
            newMyCart.productpricebefore = productDetails?.priceBeforeDiscount
            newMyCart.productrate = Double(productDetails!.rating)
            newMyCart.productfav = String(productDetails!.favorite)
            newMyCart.productquantity = quantityLbl.text
            newMyCart.productid = productDetails?.id
            SharedCoreData.myCartArray.append(newMyCart)
            SharedCoreData.saveInAwfarlak()
             CusstomAlert()
        }
    }
    
    //MARK: - Func to Create Cussstom Alert
     
     func CusstomAlert()  {
         let alertController = UIAlertController(title:"Success".localized, message:"MyCart1".localized , preferredStyle: .alert)
         alertController.addAction(UIAlertAction(title:"OK".localized, style:.default, handler:self.cartHandler))
           self.present(alertController, animated:true, completion:nil)
           
         }
     
    //MARK: - Func to Handler Action in Cussstom Alert

     func cartHandler(alert:UIAlertAction!){
             dismiss(animated: true, completion: nil)
            addToCartAndGo?.goToCart()
     }
    
    //MARK: - IBAction

    
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
    
    @IBAction func addProductToCart(_ sender: UIButton) {
        setDataInCoreData()
    }
}
