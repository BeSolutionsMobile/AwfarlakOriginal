//
//  DetailsSegmentedViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class DetailsSegmentedViewController: UIViewController {
    
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
            Services.getProductDetails(idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.productDetails = result
                    self.productData.text = self.productDetails?.productDetailsDescription
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
    
}
