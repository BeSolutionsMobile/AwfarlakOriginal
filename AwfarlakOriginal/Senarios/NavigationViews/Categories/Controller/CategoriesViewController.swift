//
//  CategoriesViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/30/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class CategoriesViewController: UIViewController {
    
    var catImage = ["Fruits" , "Vegetables" , "Herbs" , "Spices" , "TeaCoffee" , "Oils" , "ProcessedFoods" , "RiceGrains"]

     var catName = ["Fruits" , "Vegetables" , "Herbs" , "Spices" , "Tea & Coffee" , "Oils" , "Processed Foods" , "Rice & Grains"]

    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showNavigation()

        // Do any additional setup after loading the view.
    }
    

    
}



extension CategoriesViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  catImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoriesCollectionViewCell", for: indexPath) as! CategoriesCollectionViewCell
        let cellIndex = indexPath.item
        cell.categoriesImage.image = UIImage(named: catImage[cellIndex])
        cell.categoriesName.text = catName[cellIndex]
        if   cellIndex == 0  {
            RoundedCollection.topLeft(view: cell.contentView)
        }
        if   cellIndex == 1  {
            RoundedCollection.topRight(view: cell.contentView)
        }
        if   cellIndex == catImage.count - 2  {
            RoundedCollection.bootemLeft(view: cell.contentView)
        }
        if   cellIndex == catImage.count - 1  {
            RoundedCollection.bootemRight(view: cell.contentView)
        }
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProductsViewController") as! ProductsViewController
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension CategoriesViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 160)
        return cellSize
        
        
        
    }
}
