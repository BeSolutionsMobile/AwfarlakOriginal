//
//  MyComparisonCollectionViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos



//MARK: - Insert New Protocal Named TransferToCartDelegate

protocol TransferToCartDelegate {
    func transferCart(index : Int)
}
class MyComparisonCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
       
    var transferToCartDelegate : TransferToCartDelegate?
    var index : IndexPath?
    
    //MARK: - IBOutlet

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRate: CosmosView!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var addFavBtn: UIButton!{
        didSet{
            addFavBtn.isEnabled = false
        }
    }
    
    
    
    
    
    //MARK: - IBAction

    
    
    @IBAction func addCartBtnPressed(_ sender: UIButton) {
        transferToCartDelegate?.transferCart(index: index!.item)
        
    }
    
    
}
