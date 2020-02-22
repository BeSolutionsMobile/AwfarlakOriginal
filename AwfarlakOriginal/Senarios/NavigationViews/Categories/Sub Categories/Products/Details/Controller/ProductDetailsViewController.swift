//
//  ProductDetailsViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/31/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import ImageSlideshow
import MOLH

class ProductDetailsViewController: UIViewController {
    
    //MARK: - Variables
    
    weak var currentViewController : UIViewController?
    static var idProduct : String?
    var productDetails : ProductDetails?
    var imageKingImageSrc = [KingfisherSource]()
    
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productImageSilder: ImageSlideshow!
    
    @IBOutlet weak var priceProduct: UILabel!{
        didSet{
            priceProduct.layer.cornerRadius = priceProduct.frame.size.height / 2
            priceProduct.clipsToBounds = true
            priceProduct.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
        }
    }
    
    @IBOutlet weak var segmentedBtn: UISegmentedControl!{
        didSet{
            self.customizeSigmanted(for: self.segmentedBtn)
        }
    }
    @IBOutlet weak var viewChoise: UIView!
    @IBOutlet weak var callBtn: UIButton!
    @IBOutlet weak var addCartBtn: UIButton!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateViewDesign()
        getProductDetails()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Func to Get Product Details
    
    func getProductDetails()  {
        if let idProduct = ProductDetailsViewController.idProduct {
            Services.getProductDetails(idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.productDetails = result
                    self.completeData()
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
    
    //MARK: - Func to Complete Data Of Product
    
    func completeData ()  {
        if productDetails != nil {
            title = productDetails?.title
            priceProduct.attributedText = NSAttributedString.withDualText(text1: "Rs".localized, ofSizeText1: 20, text2: productDetails!.priceAfterDiscount, ofSizeText2: 20)
            if let details = productDetails?.album {
                for dItem in details {
                    let image = KingfisherSource(urlString: dItem)
                    self.imageKingImageSrc.append(image!)
                }
                self.productImageSilder.setImageInputs(self.imageKingImageSrc)
            }
            
        }
    }
    
    
    //MARK: - Func to Update Design
    
    func updateViewDesign() {
        designSliderImage(imageSilder: productImageSilder)
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsSegmentedViewController")
        self.currentViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.viewChoise)
        chkDesignBtn()
    }
    
    //MARK: - Func to Change Design According to the Language
    
    func chkDesignBtn()  {
        if MOLHLanguage.currentAppleLanguage() == "en"{
            addCartBtn.layer.cornerRadius = addCartBtn.frame.size.height / 2
            addCartBtn.clipsToBounds = true
            addCartBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
            callBtn.layer.cornerRadius = callBtn.frame.size.height / 2
            callBtn.clipsToBounds = true
            callBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
            priceProduct.layer.cornerRadius = priceProduct.frame.size.height / 2
            priceProduct.clipsToBounds = true
            priceProduct.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            addCartBtn.layer.cornerRadius = addCartBtn.frame.size.height / 2
            addCartBtn.clipsToBounds = true
            addCartBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
            callBtn.layer.cornerRadius = callBtn.frame.size.height / 2
            callBtn.clipsToBounds = true
            callBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
            priceProduct.layer.cornerRadius = priceProduct.frame.size.height / 2
            priceProduct.clipsToBounds = true
            priceProduct.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
            
        }
        
    }
    //MARK: - Func to Insert Image Slide And Page Controller
    
    func designSliderImage(imageSilder : ImageSlideshow) {
        imageSilder.slideshowInterval = 5.0
        imageSilder.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
        imageSilder.contentScaleMode = UIViewContentMode.scaleAspectFill
        let pageControl = UIPageControl()
        pageControl.currentPageIndicatorTintColor = UIColor.init(named: "BtnColor")
        pageControl.pageIndicatorTintColor = UIColor.white
        imageSilder.pageIndicator = pageControl
        imageSilder.activityIndicator = DefaultActivityIndicator()
        imageSilder.activityIndicator = DefaultActivityIndicator()
        imageSilder.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
        imageSilder.addGestureRecognizer(recognizer)
    }
    
    //MARK: - Func to Press In One Image In Image Slider
    
    @objc func didTap() {
        let fullScreenController = productImageSilder.presentFullScreenController(from: self)
        fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)
    }
    
    //MARK:- Customize Segmant Controller
    func customizeSigmanted(for segmantController: UISegmentedControl) {
        let titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16, weight: .semibold)]
        
        let selectedTitleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white , NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18, weight: .semibold)]
        
        segmantController.setTitleTextAttributes(titleTextAttributes, for: .normal)
        segmantController.setTitleTextAttributes(selectedTitleTextAttributes, for: .selected)
        
        
    }
    
    //MARK: - One Func to Change View When Press In Siggmanted
    
    func cycleFromViewController(oldViewController: UIViewController, toViewController newViewController: UIViewController) {
        oldViewController.willMove(toParent: nil)
        self.addChild(newViewController)
        self.addSubview(subView: newViewController.view, toView:self.viewChoise!)
        newViewController.view.alpha = 0
        newViewController.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.5, animations: {
            newViewController.view.alpha = 1
            oldViewController.view.alpha = 0
        },completion: { finished in
            oldViewController.view.removeFromSuperview()
            oldViewController.removeFromParent()
            newViewController.didMove(toParent: self)
        }
        )
    }
    
    //MARK: - Two Func to Change View When Press In Siggmanted
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
    //MARK: - IBAction
    
    @IBAction func changeView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsSegmentedViewController")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
        }  else {
            let newViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentsSegmentedViewController")
            newViewController!.view.translatesAutoresizingMaskIntoConstraints = false
            
            self.cycleFromViewController(oldViewController: self.currentViewController!, toViewController: newViewController!)
            self.currentViewController = newViewController
            
        }
    }
    
    
    @IBAction func addRateBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddRateViewController") as! AddRateViewController
        vc.idProduct = ProductDetailsViewController.idProduct
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
        
    }
    
    
    @IBAction func callBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func addCartBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddCartPopupViewController") as! AddCartPopupViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
