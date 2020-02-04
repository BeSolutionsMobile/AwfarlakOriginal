//
//  MyCartTableViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/2/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos
class MyCartTableViewCell: UITableViewCell {
    var quantity : Int = 1
    @IBOutlet weak var cornerView: UIView!{
        didSet{
            cornerView.layer.cornerRadius = 20
            cornerView.layer.borderWidth = 1.0
            cornerView.layer.borderColor = #colorLiteral(red: 0.9098039216, green: 0.6235294118, blue: 0.09803921569, alpha: 1)
            cornerView.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productRate: CosmosView!
    @IBOutlet weak var oldPriceView: UIView!
    @IBOutlet weak var oldPriceLbl: UILabel!
    @IBOutlet weak var priceNow: UILabel!
    @IBOutlet weak var productCount: UILabel!
    @IBOutlet weak var favBtn: UIButton!{
        didSet{
            favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
        }
    }
    
    @IBOutlet weak var quantityView: UIView!{
        didSet{
           quantityView.layer.cornerRadius = quantityView.frame.size.height / 2
           quantityView.clipsToBounds = true
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    @IBAction func minusBtnPressed(_ sender: UIButton) {
        if quantity == 1 {
            productCount.text = String(quantity)
        }else {
            quantity = quantity - 1
            productCount.text = String(quantity)
        }
    }
    
    @IBAction func plusBtnPressed(_ sender: UIButton) {
        quantity = quantity + 1
        productCount.text = String(quantity)
    }
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
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
    
}
