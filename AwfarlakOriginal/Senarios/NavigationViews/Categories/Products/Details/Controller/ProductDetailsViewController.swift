//
//  ProductDetailsViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/31/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import ImageSlideshow


class ProductDetailsViewController: UIViewController {
    weak var currentViewController : UIViewController?

    @IBOutlet weak var productImageSilder: ImageSlideshow!{
        didSet{
            productImageSilder.setImageInputs([
            ImageSource(image: UIImage(named: "Mango1")!),
            ImageSource(image: UIImage(named: "Mango2")!),
            ImageSource(image: UIImage(named: "Mango3")!)
           ])
        }
    }
   
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
    @IBOutlet weak var callBtn: UIButton!{
        didSet{
           callBtn.layer.cornerRadius = callBtn.frame.size.height / 2
           callBtn.clipsToBounds = true
           callBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
        }
    }
    @IBOutlet weak var addCartBtn: UIButton!{
        didSet{
           addCartBtn.layer.cornerRadius = addCartBtn.frame.size.height / 2
           addCartBtn.clipsToBounds = true
           addCartBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateViewDesign()

        // Do any additional setup after loading the view.
    }
    

    func updateViewDesign() {
        designSliderImage(imageSilder: productImageSilder)
        priceProduct.attributedText = NSAttributedString.withDualText(text1: "Rs.3.75", ofSizeText1: 20, text2: "/KG", ofSizeText2: 20)
        self.currentViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailsSegmentedViewController")
        self.currentViewController?.view.translatesAutoresizingMaskIntoConstraints = false
        self.addChild(self.currentViewController!)
        self.addSubview(subView: self.currentViewController!.view, toView: self.viewChoise)
    }
    
      func designSliderImage(imageSilder : ImageSlideshow) {
      imageSilder.slideshowInterval = 5.0
      imageSilder.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
      imageSilder.contentScaleMode = UIViewContentMode.scaleAspectFill
      
      let pageControl = UIPageControl()
      pageControl.currentPageIndicatorTintColor = UIColor.init(named: "BtnColor")
      pageControl.pageIndicatorTintColor = UIColor.white
      pageControl.numberOfPages = 3
      imageSilder.pageIndicator = pageControl
      imageSilder.activityIndicator = DefaultActivityIndicator()
      imageSilder.activityIndicator = DefaultActivityIndicator()
      imageSilder.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)

      let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
      imageSilder.addGestureRecognizer(recognizer)
      }
      
      
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
    
    func addSubview(subView:UIView, toView parentView:UIView) {
        parentView.addSubview(subView)
        var viewBindingsDict = [String: AnyObject]()
        viewBindingsDict["subView"] = subView
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
        parentView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subView]|",
                                                                 options: [], metrics: nil, views: viewBindingsDict))
    }
    
    
    
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
    
    
    @IBAction func callBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func addCartBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddCartPopupViewController") as! AddCartPopupViewController
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    
}
