//
//  MyFavouriteViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class MyFavouriteViewController: UIViewController {
    var MyFavouriteImage = ["Orange" , "Mango" , "Apple2" , "Apple" , "Kiwi" , "Banana" , "Pineapple" , "Tomato" , "Strawberry" , "Grapes"]

    var MyFavouriteName = ["Orange" , "Mango" , "Apple" , "Apple" , "Kiwi" , "Banana" , "Pineapple" , "Tomato" , "Strawberry" , "Grapes" ]
    @IBOutlet weak var myFavouriteCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()

        // Do any additional setup after loading the view.
    }
    

    

}

extension MyFavouriteViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  MyFavouriteImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyFavouriteCollectionViewCell", for: indexPath) as! MyFavouriteCollectionViewCell
        cell.contentView.layer.cornerRadius = 25
        let cellIndex = indexPath.item
        cell.productFavImage.image  = UIImage(named: MyFavouriteImage[cellIndex])
        cell.productFavName.text = MyFavouriteName[cellIndex]
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension MyFavouriteViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 250)
        return cellSize
        
        
        
    }
}
