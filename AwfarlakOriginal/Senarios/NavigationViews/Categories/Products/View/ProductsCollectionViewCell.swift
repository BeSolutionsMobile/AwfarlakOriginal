//
//  ProductsCollectionViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/31/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos
import MOLH
protocol FavAnimationDelegate {
    func startFavAnimation()
}
class ProductsCollectionViewCell: UICollectionViewCell {
    var delegate: FavAnimationDelegate?

    @IBOutlet weak var discountImageBg: UIImageView!{
        didSet{
            chkDesignBtn()
        }
    }
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
    
    
    
    
    
    func chkDesignBtn()  {
        if MOLHLanguage.currentAppleLanguage() == "en"{
            discountImageBg.image = UIImage(named: "DiscountBg")
            
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            discountImageBg.image = UIImage(named: "DiscountBgAr")

        }
        
    }
    
    
    
    
    
    
    
    
    
    @IBAction func comparisonBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func favBtnPressed(_ sender: UIButton) {
        if favBtn.image(for: .normal) == UIImage(named: "Fav1") {
            self.favBtn.setImage(UIImage(named: "Fav2"), for: .normal)
            delegate?.startFavAnimation()
            
        }
        else if favBtn.image(for: .normal) == UIImage(named: "Fav2") {
            self.favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
            
        }
    }
    
    @IBAction func addToCartBtnPressed(_ sender: UIButton) {
    }
    
    
}
