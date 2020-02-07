//
//  MyComparisonCollectionViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/3/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos
class MyComparisonCollectionViewCell: UICollectionViewCell {
    var delegate: FavAnimationDelegate?

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRate: CosmosView!
    @IBOutlet weak var productBuyers: UILabel!
    @IBOutlet weak var productPrice: UILabel!
    
    @IBOutlet weak var addFavBtn: UIButton!{
        didSet{
            addFavBtn.setImage(UIImage(named: "Fav1"), for: .normal)
        }
    }
    
    
    
    
    
    
    
    @IBAction func addFavBtnPressed(_ sender: UIButton) {
        if addFavBtn.image(for: .normal) == UIImage(named: "Fav1") {
            self.addFavBtn.setImage(UIImage(named: "Fav2"), for: .normal)
            delegate?.startFavAnimation()

            
        }
        else if addFavBtn.image(for: .normal) == UIImage(named: "Fav2") {
            self.addFavBtn.setImage(UIImage(named: "Fav1"), for: .normal)
            
        }
    }
    
    @IBAction func addCartBtnPressed(_ sender: UIButton) {
    }
    
    
}
