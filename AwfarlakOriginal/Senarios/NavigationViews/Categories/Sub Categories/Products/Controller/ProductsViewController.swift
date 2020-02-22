//
//  ProductsViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/31/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH

class ProductsViewController: UIViewController {
    
    //MARK: - Variables
    
    var products : Products?
    var idSubCategory : String?
    var titleSubCategory : String?
    var pageNumber : Int = 1
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var productAnimationFav: UIView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateDesign()
        getAllProductOfSubCategories()
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Func to Update Design
    
    func updateDesign()  {
        productAnimationFav.isHidden = true
        title =  titleSubCategory
    }
    
    //MARK: - Func to Get All Product Of Sub Categories
    
    func getAllProductOfSubCategories()  {
        if let idSubCategory = idSubCategory {
            Services.getAllProductOfSubCategories(idSubCategory: idSubCategory, idUser: UserDefault.getId(), pageNumber: pageNumber, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.products = result
                    self.productCollectionView.reloadData()
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                case 3:
                    RoundedCollection.emptyData(collectionView: self.productCollectionView, View: self.view, MessageText: result.message!)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Func to Get Product Of Sub Categories Pagination
    
    func getProductOfSubCategoriesPagination()  {
        if let idSubCategory = idSubCategory {
            Services.getAllProductOfSubCategories(idSubCategory: idSubCategory, idUser: UserDefault.getId(), pageNumber: pageNumber, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    let  number : Int = result.products!.count
                    print(number)
                    for i in 0..<number{
                        self.products?.products?.append((result.products?[i])!)
                        self.productCollectionView.reloadData()
                    }
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                case 3:
                    RoundedCollection.emptyData(collectionView: self.productCollectionView, View: self.view, MessageText: result.message!)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    
    
    
}



//MARK: - Extension

//MARK:-UICollectionViewDelegate And UICollectionViewDataSource

extension ProductsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  products?.products?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        let cellIndex = indexPath.item
        cell.productImage.sd_setImage(with: URL(string: products?.products?[cellIndex].image ?? ""), placeholderImage: UIImage(named: "logo GoAhead"))
        cell.productName.text = products?.products?[cellIndex].title
        cell.productPrice.text = "Rs.\(products?.products?[cellIndex].priceAfterDiscount ?? "")"
        cell.productRate.rating = Double((products?.products?[cellIndex].rating)!)!
        cell.discountText.text =  products?.products?[cellIndex].discount
        if products?.products?[indexPath.item].favorite == 0 {
            cell.favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
        }else if products?.products?[indexPath.item].favorite == 1 {
            cell.favBtn.setImage(UIImage(named: "Fav2"), for: .normal)
        }
        cell.idProduct = products?.products?[cellIndex].id
        cell.numberOfBuyers.isHidden = true
        cell.delegate = self
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
        ProductDetailsViewController.idProduct = products?.products?[indexPath.item].id
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if indexPath.item == (products?.products?.count ?? 0) - 1 {
            pageNumber = pageNumber + 1
            print(pageNumber)
            getProductOfSubCategoriesPagination()
        }
        
    }
    
    
    
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 300)
        return cellSize
        
    }
}


//MARK:-FavAnimationDelegate

extension ProductsViewController : FavAnimationDelegate {
    func startFavAnimation() {
        productAnimationFav.isHidden = false
        let view = StartAnimationView.showLottie(view: self.productAnimationFav, fileName: "fav", contentMode: .scaleAspectFit)
        view.animationSpeed = 0.8
        view.play { (finished) in
            if finished {
                self.productAnimationFav.isHidden = true
                
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    
}
