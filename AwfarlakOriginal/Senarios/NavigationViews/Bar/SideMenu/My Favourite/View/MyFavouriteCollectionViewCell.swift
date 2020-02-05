//
//  MyFavouriteCollectionViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/5/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

class MyFavouriteCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var productFavImage: UIImageView!
    
    @IBOutlet weak var productFavName: UILabel!
    @IBOutlet weak var productFavRate: CosmosView!
    @IBOutlet weak var productFavPrice: UILabel!
    @IBOutlet weak var ProductMyFavBtn: UIButton!
    
    
    
    
    
    @IBAction func produtMyFavBtnPreesed(_ sender: UIButton) {
    }
    
    @IBAction func productFavCartBtnPreesed(_ sender: UIButton) {
    }
}
