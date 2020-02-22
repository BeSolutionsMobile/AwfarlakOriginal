//
//  MyFavouriteViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class MyFavouriteViewController: UIViewController {
    
    //MARK: - Variables
    
    var favoriteProducts : FavoriteProducts?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var myFavouriteCollectionView: UICollectionView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        getFavoriteProduct()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Func to Get  Favorite Product
    
    func getFavoriteProduct()  {
        Services.getFavoriteProduct(idUser: UserDefault.getId(), callback: { (result) in
            print(result)
            switch result.status {
            case 1:
                self.favoriteProducts = result
                self.myFavouriteCollectionView.reloadData()
            case 2:
                Alert.show("Error".localized, massege: result.message!, context: self)
            case 3:
                RoundedCollection.emptyData(collectionView: self.myFavouriteCollectionView, View: self.view, MessageText: result.message!)
            default:
                print(result.status)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
        
    }
    
    
    
    
    
}

//MARK: - Extension

//MARK:-UICollectionViewDelegate And UICollectionViewDataSource

extension MyFavouriteViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  favoriteProducts?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFavouriteCollectionViewCell", for: indexPath) as! MyFavouriteCollectionViewCell
        cell.contentView.layer.cornerRadius = 25
        let cellIndex = indexPath.item
        cell.productFavImage.sd_setImage(with: URL(string: favoriteProducts?.products?[cellIndex].image ?? ""), placeholderImage: UIImage(named: "logo GoAhead"))
        cell.productFavName.text = favoriteProducts?.products?[cellIndex].title
        cell.productFavPrice.text = "Rs.\(favoriteProducts?.products?[cellIndex].priceAfterDiscount ?? "")"
        cell.productFavRate.rating = Double((favoriteProducts?.products?[cellIndex].rating)!)!
        cell.idProduct = favoriteProducts?.products?[cellIndex].id
        cell.delegate = self
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension MyFavouriteViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 300)
        return cellSize
        
        
        
    }
}

//MARK:- ReloadCollectionViewFavourite

extension MyFavouriteViewController: ReloadCollectionViewFavourite {
    func realodNow() {
        favoriteProducts?.products?.removeAll()
        getFavoriteProduct()
    }
    
    
}
