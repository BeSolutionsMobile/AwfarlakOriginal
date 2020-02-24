//
//  DetailsSegmentedViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class DetailsSegmentedViewController: UIViewController , NVActivityIndicatorViewable {
    
    //MARK: - Variables
    
    var productDetails : ProductDetails?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productData: UILabel!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getProductDescription()
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Func to Get Product Description
    
    func getProductDescription()  {
        if let idProduct = ProductDetailsViewController.idProduct {
            self.startAnimating()
            Services.getProductDetails(idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.productDetails = result
                    self.productData.text = self.productDetails?.productDetailsDescription
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
    
}
