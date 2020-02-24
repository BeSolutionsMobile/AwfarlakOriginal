//
//  MyCartTableViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/2/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

//MARK: - Insert New Protocal Named UpdateCart

protocol UpdateCart {
    func update(countText : String , index : Int)
     func delete( index : Int)
    
}
class MyCartTableViewCell: UITableViewCell {
    
    
    //MARK: - Variables
       
    var index : IndexPath?
    var delegate: UpdateCart?
    var quantity : Int = 1
   
    
    
    //MARK: - IBOutlet

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
            favBtn.isEnabled = false
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
    
    
    //MARK: - IBAction
    
    @IBAction func minusBtnPressed(_ sender: UIButton) {
        if quantity == 1 {
            productCount.text = String(quantity)
           delegate?.update(countText: productCount.text!, index: index!.row)
        }else {
            quantity = quantity - 1
            productCount.text = String(quantity)
            delegate?.update(countText: productCount.text!, index: index!.row)
           
        }
    }
    
    @IBAction func plusBtnPressed(_ sender: UIButton) {
        quantity = quantity + 1
        productCount.text = String(quantity)
        delegate?.update(countText: productCount.text!, index: index!.row)

    }
    
    @IBAction func deleteBtnPressed(_ sender: UIButton) {
        delegate?.delete(index: index!.row)
    }
    
    
    
    
}
