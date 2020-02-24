//
//  ProductsViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/31/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH
import CoreData
import NVActivityIndicatorView

class ProductsViewController: UIViewController  , NVActivityIndicatorViewable{
    
    //MARK: - Variables
    
    var products : Products?
    var idSubCategory : String?
    var titleSubCategory : String?
    var pageNumber : Int = 1
    var sender : Int = 1
    var Search : Search?
    var searchText : String?
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var productCollectionView: UICollectionView!
    @IBOutlet weak var productAnimationFav: UIView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        showAndBacNavigation()
        updateDesign()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showAndBacNavigation()
        if sender == 1 {
            getAllProductOfSubCategories()
        }else {
            getSearchResult()
        }
        SharedCoreData.loadMyComparison()
    }
    
    //MARK: - Func to Update Design
    
    func updateDesign()  {
        productAnimationFav.isHidden = true
        title =  titleSubCategory
    }
    
    //MARK: - Func to Get All Product Of Sub Categories
    
    func getAllProductOfSubCategories()  {
        self.startAnimating()
        if let idSubCategory = idSubCategory {
            Services.getAllProductOfSubCategories(idSubCategory: idSubCategory, idUser: UserDefault.getId(), pageNumber: pageNumber, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.products = result
                    self.productCollectionView.reloadData()
                    self.stopAnimating()
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                    self.stopAnimating()
                case 3:
                    RoundedCollection.emptyData(collectionView: self.productCollectionView, View: self.view, MessageText: result.message!)
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
    
    //MARK: - Func to Get Product Of Sub Categories Pagination
    
    func getProductOfSubCategoriesPagination(){
        self.startAnimating()
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
                    self.stopAnimating()
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                    self.stopAnimating()
                case 3:
                    RoundedCollection.emptyData(collectionView: self.productCollectionView, View: self.view, MessageText: result.message!)
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
    
    
    
    //MARK: - Func to Validation Comparision
    
    func validateToComparision()->Bool {
        if products?.products != nil {
            if SharedCoreData.myComparisonArray.count < 2 {
                return true
            }else {
                Alert.show("Error".localized, massege:"MyComparison1".localized, context: self)
                return false
            }
        }else {
            return false
        }
        
    }
    
    
    //MARK: - Func to Get Search Result
    
    func getSearchResult()  {
        if let searchText = searchText {
            self.startAnimating()
            Services.getSearchResult(searchWord: searchText, idUser: UserDefault.getId(),  callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.Search = result
                    self.productCollectionView.reloadData()
                    self.stopAnimating()
                case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
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
    
    
    
    
    
    
}



//MARK: - Extension

//MARK:-UICollectionViewDelegate And UICollectionViewDataSource

extension ProductsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if sender == 1 {
            return  products?.products?.count ?? 0
        }else {
            return  Search?.products?.count ?? 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        let cellIndex = indexPath.item
        if sender == 1 {
            cell.productImage.sd_setImage(with: URL(string: products?.products?[cellIndex].image ?? ""), placeholderImage: UIImage(named: "appIcon1"))
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
        }else {
            cell.productImage.sd_setImage(with: URL(string: Search?.products?[cellIndex].image ?? ""), placeholderImage: UIImage(named: "appIcon1"))
            cell.productName.text = Search?.products?[cellIndex].title
            cell.productPrice.text = "Rs.\(Search?.products?[cellIndex].priceAfterDiscount ?? "")"
            cell.productRate.rating = Double((Search?.products?[cellIndex].rating)!)!
            cell.discountText.text =  Search?.products?[cellIndex].discount
            if Search?.products?[indexPath.item].favorite == 0 {
                cell.favBtn.setImage(UIImage(named: "Fav1"), for: .normal)
            }else if Search?.products?[indexPath.item].favorite == 1 {
                cell.favBtn.setImage(UIImage(named: "Fav2"), for: .normal)
            }
            cell.idProduct = Search?.products?[cellIndex].id
            
        }
        
        cell.numberOfBuyers.isHidden = true
        cell.delegate = self
        cell.index = indexPath
        cell.delegateComparison = self
        cell.transferToCartDelegate = self
        return cell
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sender == 1 {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            ProductDetailsViewController.idProduct = products?.products?[indexPath.item].id
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)                      }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "ProductDetailsViewController") as! ProductDetailsViewController
            ProductDetailsViewController.idProduct = Search?.products?[indexPath.item].id
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)                      }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if sender == 1 {
            if indexPath.item == (products?.products?.count ?? 0) - 1 {
                pageNumber = pageNumber + 1
                print(pageNumber)
                getProductOfSubCategoriesPagination()
            }
            
        }else {
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

//MARK:-AddInComparison

extension ProductsViewController : AddInComparison {
    
    //MARK: - Func to Set Data In Core Data
    
    func setDataInCoreData(index: Int) {
        let newMyComparison = MyComparison(context: SharedCoreData.context)
        if sender == 1 {
            if validateToComparision() {
                newMyComparison.productimage = products?.products?[index].image
                newMyComparison.productname = products?.products?[index].title
                newMyComparison.productprice = products?.products?[index].priceAfterDiscount
                newMyComparison.productrate = Double((products?.products?[index].rating)!)!
                newMyComparison.productfav = String((products?.products?[index].favorite)!)
                newMyComparison.productid = products?.products?[index].id
                SharedCoreData.myComparisonArray.append(newMyComparison)
                SharedCoreData.saveInAwfarlak()
                Alert.show("Success".localized, massege:"MyComparison2".localized, context: self)
            }
        }else {
            newMyComparison.productimage = Search?.products?[index].image
            newMyComparison.productname = Search?.products?[index].title
            newMyComparison.productprice = Search?.products?[index].priceAfterDiscount
            newMyComparison.productrate = Double((Search?.products?[index].rating)!)!
            newMyComparison.productfav = String((Search?.products?[index].favorite)!)
            newMyComparison.productid = Search?.products?[index].id
            SharedCoreData.myComparisonArray.append(newMyComparison)
            SharedCoreData.saveInAwfarlak()
            Alert.show("Success".localized, massege:"MyComparison2".localized, context: self)            }
        
    }
}


//MARK:-TransferToCartDelegate

extension ProductsViewController : TransferToCartDelegate {
    func transferCart(index: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddCartPopupViewController") as! AddCartPopupViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.addToCartAndGo = self
        if sender == 1 {
            vc.idProduct = products?.products?[index].id
        }else {
            vc.idProduct = Search?.products?[index].id
        }
        self.present(vc, animated: true, completion: nil)
    }
}

//MARK:-AddToCartAndGo

extension ProductsViewController : AddToCartAndGo {
    func goToCart() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController {
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
}
