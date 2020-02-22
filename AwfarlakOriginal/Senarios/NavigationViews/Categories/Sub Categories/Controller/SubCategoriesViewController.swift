//
//  SubCategoriesViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/18/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import SDWebImage

class SubCategoriesViewController: UIViewController {

    //MARK: - Variables
    
    var subCategories : SubCategories?
    var idCategory : String?
    var titleCategory : String?

    //MARK: - IBOutlet
    
    @IBOutlet weak var subCategoriesCollectionView: UICollectionView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateDesign()
        getSubCategories()
    }
    
    //MARK: - Func to Update Design
       
    func updateDesign()  {
        if let titleCategory = titleCategory {
            title =  titleCategory
        }
    }
    
    //MARK: - Func to Get Sub Categories
    
    func getSubCategories()  {
        if let idCategory = idCategory {
            Services.getSubCategories(idCategory: idCategory, callback: { (result) in
                 print(result)
                 switch result.status {
                 case 1:
                     self.subCategories = result
                     self.subCategoriesCollectionView.reloadData()
                 case 2:
                     Alert.show("Error".localized, massege: result.message!, context: self)
                 case 3:
                     RoundedCollection.emptyData(collectionView: self.subCategoriesCollectionView, View: self.view, MessageText: result.message!)
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

extension SubCategoriesViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  subCategories?.catrgories?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SubCategoriesCollectionViewCell", for: indexPath) as! SubCategoriesCollectionViewCell
        let cellIndex = indexPath.item
        if   cellIndex == 0  {
            RoundedCollection.topLeft(view: cell.contentView)
        }
        else if   cellIndex == 1  {
            RoundedCollection.topRight(view: cell.contentView)
        }
        else if   cellIndex == (subCategories?.catrgories?.count ?? 0) - 2  {
            RoundedCollection.bootemLeft(view: cell.contentView)
        }
        else if   cellIndex == (subCategories?.catrgories?.count ?? 0) - 1  {
            RoundedCollection.bootemRight(view: cell.contentView)
        }else {
            RoundedCollection.simpleView(view: cell.contentView)
        }
        cell.subCategoriesImage.sd_setImage(with: URL(string: subCategories?.catrgories?[cellIndex].image ?? ""), placeholderImage: UIImage(named: "logo GoAhead"))
        cell.subCategoriesName.text = subCategories?.catrgories?[cellIndex].name
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProductsViewController") as! ProductsViewController
        vc.idSubCategory = subCategories?.catrgories?[indexPath.item].id
        vc.titleSubCategory = subCategories?.catrgories?[indexPath.item].name
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension SubCategoriesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 165)
        return cellSize
        
        
        
    }
}
