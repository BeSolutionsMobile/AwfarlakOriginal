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
    
    @IBOutlet weak var productAnimationFav: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateDesign()

        // Do any additional setup after loading the view.
    }
    
    func updateDesign()  {
        
        productAnimationFav.isHidden = true
        
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
        cell.delegate = self
        
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
