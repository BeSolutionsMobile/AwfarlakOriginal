//
//  ProductsViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/31/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ProductsViewController: UIViewController {
    var catImage = ["Orange" , "Mango" , "Apple2" , "Apple" , "Kiwi" , "Banana" , "Pineapple" , "Tomato" , "Strawberry" , "Grapes"]

    var catName = ["Orange" , "Mango" , "Apple" , "Apple" , "Kiwi" , "Banana" , "Pineapple" , "Tomato" , "Strawberry" , "Grapes" ]
    @IBOutlet weak var productCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()

        // Do any additional setup after loading the view.
    }
    

   

}


extension ProductsViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  catImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductsCollectionViewCell", for: indexPath) as! ProductsCollectionViewCell
        let cellIndex = indexPath.item
        cell.productImage.image = UIImage(named: catImage[cellIndex])
        cell.productName.text = catName[cellIndex]
       
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "ProductDetailsViewController") as! ProductDetailsViewController
              vc.modalPresentationStyle = .fullScreen
              navigationController?.pushViewController(vc, animated: true)
       
        
    }
    
    
    
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension ProductsViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 180)
        return cellSize
        
        
        
    }
}
