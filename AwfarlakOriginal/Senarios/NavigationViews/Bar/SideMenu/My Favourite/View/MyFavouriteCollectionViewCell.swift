//
//  MyFavouriteCollectionViewCell.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/5/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Cosmos

//MARK: - Insert New Protocal Named ReloadCollectionViewFavourite

protocol ReloadCollectionViewFavourite {
    func realodNow()
}
class MyFavouriteCollectionViewCell: UICollectionViewCell {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productFavImage: UIImageView!
    @IBOutlet weak var productFavName: UILabel!
    @IBOutlet weak var productFavRate: CosmosView!
    @IBOutlet weak var productFavPrice: UILabel!
    @IBOutlet weak var ProductMyFavBtn: UIButton!
    
    //MARK: - Variables
    
    var delegate: ReloadCollectionViewFavourite?
    var idProduct : String?
    var transferToCartDelegate : TransferToCartDelegate?
    var index : IndexPath?
    
    
    //MARK: - Func to Delete Product From Favorite
    
    func deleteFavoriteProduct()  {
        if let idProduct = idProduct {
            Services.deleteFavoriteProduct(idUser: UserDefault.getId(), idProduct: idProduct, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    let collection = self.superview as! UICollectionView
                    collection.reloadData()
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
    
    @IBAction func produtMyFavBtnPreesed(_ sender: UIButton) {
        deleteFavoriteProduct()
        delegate?.realodNow()
    }
    
    @IBAction func productFavCartBtnPreesed(_ sender: UIButton) {
        transferToCartDelegate?.transferCart(index: index!.item)

    }
}
