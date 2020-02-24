//
//  MyFavouriteViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class MyFavouriteViewController: UIViewController  , NVActivityIndicatorViewable{
    
    //MARK: - Variables
    
    var favoriteProducts : FavoriteProducts?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var myFavouriteCollectionView: UICollectionView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showAndBacNavigation()
        getFavoriteProduct()
    }
    
    //MARK: - Func to Get  Favorite Product
    
    func getFavoriteProduct()  {
        self.startAnimating()
        Services.getFavoriteProduct(idUser: UserDefault.getId(), callback: { (result) in
            print(result)
            switch result.status {
            case 1:
                self.favoriteProducts = result
                self.myFavouriteCollectionView.reloadData()
                self.stopAnimating()
            case 2:
                Alert.show("Error".localized, massege: result.message!, context: self)
                self.stopAnimating()
            case 3:
                RoundedCollection.emptyData(collectionView: self.myFavouriteCollectionView, View: self.view, MessageText: result.message!)
                self.stopAnimating()
            default:
                print(result.status)
                self.stopAnimating()
            }
        }) { (error) in
            print(error.localizedDescription)
            self.stopAnimating()
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
        cell.productFavImage.sd_setImage(with: URL(string: favoriteProducts?.products?[cellIndex].image ?? ""), placeholderImage: UIImage(named: "appIcon1"))
        cell.productFavName.text = favoriteProducts?.products?[cellIndex].title
        cell.productFavPrice.text = "Rs.\(favoriteProducts?.products?[cellIndex].priceAfterDiscount ?? "")"
        cell.productFavRate.rating = Double((favoriteProducts?.products?[cellIndex].rating)!)!
        cell.idProduct = favoriteProducts?.products?[cellIndex].id
        cell.delegate = self
        cell.index = indexPath
        cell.transferToCartDelegate = self
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

//MARK:-TransferToCartDelegate

extension MyFavouriteViewController : TransferToCartDelegate {
    func transferCart(index: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddCartPopupViewController") as! AddCartPopupViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.idProduct = favoriteProducts?.products?[index].id
        vc.addToCartAndGo = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

//MARK:-AddToCartAndGo

extension MyFavouriteViewController : AddToCartAndGo {
    func goToCart() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController {
            vc.modalPresentationStyle = .fullScreen
              navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
   
}
    

