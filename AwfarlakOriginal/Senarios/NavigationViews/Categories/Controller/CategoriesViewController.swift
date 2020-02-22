//
//  CategoriesViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/30/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import SDWebImage
class CategoriesViewController: UIViewController {
    
    
    //MARK: - Variables
    
    var categories : Categories?
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigation()
        getAllCategories()
        
        // Do any additional setup after loading the view.
    }
    
    
    //MARK: - Func to Get All Categories
    
    func getAllCategories()  {
        Services.getAllCategories(callback: { (result) in
            print(result)
            switch result.status {
            case 1:
                self.categories = result
                self.categoriesCollectionView.reloadData()
            case 2:
                Alert.show("Error".localized, massege: result.message!, context: self)
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


extension CategoriesViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  categories?.catrgories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        let cellIndex = indexPath.item
        if   cellIndex == 0  {
            RoundedCollection.topLeft(view: cell.contentView)
        }
        else if   cellIndex == 1  {
            RoundedCollection.topRight(view: cell.contentView)
        }
        else if   cellIndex == (categories?.catrgories?.count ?? 0) - 2  {
            RoundedCollection.bootemLeft(view: cell.contentView)
        }
        else if   cellIndex == (categories?.catrgories?.count ?? 0) - 1  {
            RoundedCollection.bootemRight(view: cell.contentView)
        }else {
            RoundedCollection.simpleView(view: cell.contentView)
        }
        cell.categoriesImage.sd_setImage(with: URL(string: categories?.catrgories?[cellIndex].image ?? ""), placeholderImage: UIImage(named: "logo GoAhead"))
        cell.categoriesName.text = categories?.catrgories?[cellIndex].name
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "SubCategoriesViewController") as! SubCategoriesViewController
        vc.idCategory = categories?.catrgories?[indexPath.item].id
        vc.titleCategory = categories?.catrgories?[indexPath.item].name
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension CategoriesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 165)
        return cellSize
        
        
        
    }
}
