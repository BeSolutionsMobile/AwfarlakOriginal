//
//  MyComparisonViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class MyComparisonViewController: UIViewController {
    
    var ComparisonImage = ["Strawberry" , "Apple"]
    
    var ComparisonName = ["Strawberry" , "Apple" ]
    
    @IBOutlet weak var myComparisonCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        
        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func finishComparisionBtnPressed(_ sender: UIButton) {
    }
    
}


extension MyComparisonViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  ComparisonName.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyComparisonCollectionViewCell", for: indexPath) as! MyComparisonCollectionViewCell
        let cellIndex = indexPath.item
        cell.productImage.image  = UIImage(named: ComparisonImage[cellIndex])
        cell.productName.text = ComparisonName[cellIndex]
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        
    }
    
    
    
    
}



//MARK:-UICollectionViewDelegateFlowLayout

extension MyComparisonViewController : UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize{
        let cellSize = CGSize(width: self.view.frame.width / 2 - 20 , height: 300)
        return cellSize
        
        
        
    }
}


