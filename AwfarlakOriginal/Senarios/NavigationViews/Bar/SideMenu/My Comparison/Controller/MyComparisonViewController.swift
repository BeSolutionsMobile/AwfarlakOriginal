//
//  MyComparisonViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class MyComparisonViewController: UIViewController {
    @IBOutlet weak var comparisionAnimationView: UIView!
    
    var ComparisonImage = ["Strawberry" , "Apple"]
    
    var ComparisonName = ["Strawberry" , "Apple" ]
    
    @IBOutlet weak var myComparisonCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
         updateDesign()
        
        // Do any additional setup after loading the view.
    }
    
    func updateDesign()  {
        comparisionAnimationView.isHidden = true
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
        cell.delegate = self
        
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




extension MyComparisonViewController : FavAnimationDelegate {
    func startFavAnimation() {
        comparisionAnimationView.isHidden = false
        let view = StartAnimationView.showLottie(view: self.comparisionAnimationView, fileName: "fav", contentMode: .scaleAspectFit)
        view.animationSpeed = 0.8
        view.play { (finished) in
            if finished {
               self.comparisionAnimationView.isHidden = true
                
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    
}
