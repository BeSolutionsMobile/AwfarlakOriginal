//
//  ProductsCollectionViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/31/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

class ProductsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var discountView: UIView!
    @IBOutlet weak var numberOfBuyers: UILabel!
    @IBOutlet weak var productRate: CosmosView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var favBtn: UIButton!{
        didSet{
            favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    @IBAction func comparisonBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func favBtnPressed(_ sender: UIButton) {
        if favBtn.image(for: .normal) == UIImage(named: "Fav1") {
            self.favBtn.setImage(UIImage(named: "Fav2"), for: .normal)
            
        }
        else if favBtn.image(for: .normal) == UIImage(named: "Fav2") {
            self.favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
            
        }
    }
    
    @IBAction func addToCartBtnPressed(_ sender: UIButton) {
    }
    
    
}
