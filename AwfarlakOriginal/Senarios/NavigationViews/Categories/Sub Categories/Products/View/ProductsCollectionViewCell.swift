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

//MARK: - Insert New Protocal Named FavAnimationDelegate

protocol FavAnimationDelegate {
    func startFavAnimation()
}
protocol AddInComparison {
     func setDataInCoreData( index : Int)
}

class ProductsCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Variables
    
    var delegate: FavAnimationDelegate?
    var delegateComparison: AddInComparison?
     var index : IndexPath?
    var transferToCartDelegate : TransferToCartDelegate?
    var idProduct : String?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var discountImageBg: UIImageView!{
        didSet{
            chkDesignBtn()
        }
    }
    @IBOutlet weak var discountText: UILabel!
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
    
    
    
    
    //MARK: - Func to Change Design According to the Language
    
    func chkDesignBtn()  {
        if MOLHLanguage.currentAppleLanguage() == "en"{
            discountImageBg.image = UIImage(named: "DiscountBg")
            
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            discountImageBg.image = UIImage(named: "DiscountBgAr")
            
        }
    }
    
    
    
    
    //MARK: - Func to Add Product To Favorite
    
    func addFavoriteProduct()  {
        if let idProduct = idProduct {
            Services.addFavoriteProduct(idUser: UserDefault.getId(), idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.favBtn.setImage(UIImage(named: "Fav2"), for: .normal)
                case 2:
                    print(result.message)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Func to Delete Product From Favorite
    
    func deleteFavoriteProduct()  {
        if let idProduct = idProduct {
            Services.deleteFavoriteProduct(idUser: UserDefault.getId(), idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
                case 2:
                    print(result.message)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: - IBAction
    
    
    @IBAction func comparisonBtnPressed(_ sender: UIButton) {
        delegateComparison?.setDataInCoreData(index: index!.item)
    }
    
    @IBAction func favBtnPressed(_ sender: UIButton) {
        if favBtn.image(for: .normal) == UIImage(named: "Fav1") {
            addFavoriteProduct()
            delegate?.startFavAnimation()
            
        }
        else if favBtn.image(for: .normal) == UIImage(named: "Fav2") {
            deleteFavoriteProduct()
        }
    }
    
    @IBAction func addToCartBtnPressed(_ sender: UIButton) {
        transferToCartDelegate?.transferCart(index: index!.item)
        
    }
    
    
}
