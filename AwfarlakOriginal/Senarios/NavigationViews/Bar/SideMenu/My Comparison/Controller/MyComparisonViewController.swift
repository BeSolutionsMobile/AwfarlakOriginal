//
//  MyComparisonViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class MyComparisonViewController: UIViewController {
    
    
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var comparisionAnimationView: UIView!
    @IBOutlet weak var myComparisonCollectionView: UICollectionView!
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        SharedCoreData.loadMyComparison()
        updateDesign()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showAndBacNavigation()
        SharedCoreData.loadMyComparison()
        
    }
    
    //MARK: - Func to  Update Design
    
    func updateDesign()  {
        comparisionAnimationView.isHidden = true
        ValidateMyMyComparison()
    }
    
    //MARK: - Func to  Remove My Comparison
    
    func removeMyMyComparison()  {
        SharedCoreData.deleteMyComparison()
        SharedCoreData.myComparisonArray.removeAll()
        SharedCoreData.saveInAwfarlak()
        myComparisonCollectionView.reloadData()
        Alert.show("Success".localized, massege:"MyComparison4".localized, context: self)
        RoundedCollection.emptyData(collectionView: self.myComparisonCollectionView, View: self.view, MessageText: "MyComparison3".localized)
        
    }
    
    //MARK: - Func to  Validate My Comparison
    
    func ValidateMyMyComparison()  {
        if  SharedCoreData.myComparisonArray.count == 0 {
            RoundedCollection.emptyData(collectionView: self.myComparisonCollectionView, View: self.view, MessageText: "MyComparison3".localized)
        }
    }
    
    //MARK: - IBAction
    
    @IBAction func finishComparisionBtnPressed(_ sender: UIButton) {
        removeMyMyComparison()
        
        
    }
    
}

//MARK: - Extension

//MARK:-UICollectionViewDelegate And UICollectionViewDataSource


extension MyComparisonViewController : UICollectionViewDelegate , UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  SharedCoreData.myComparisonArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MyComparisonCollectionViewCell", for: indexPath) as! MyComparisonCollectionViewCell
        let cellIndex = indexPath.item
        cell.productImage.sd_setImage(with: URL(string: SharedCoreData.myComparisonArray[cellIndex].productimage ?? ""), placeholderImage: UIImage(named: "appIcon1"))
        cell.productName.text = SharedCoreData.myComparisonArray[cellIndex].productname
        cell.productPrice.text = "Rs.\(SharedCoreData.myComparisonArray[cellIndex].productprice ?? "")"
        cell.productRate.rating = SharedCoreData.myComparisonArray[cellIndex].productrate
        if SharedCoreData.myComparisonArray[cellIndex].productfav == "0" {
            cell.addFavBtn.setImage(UIImage(named: "Fav1"), for: .normal)
        }else if SharedCoreData.myComparisonArray[cellIndex].productfav == "1" {
            cell.addFavBtn.setImage(UIImage(named: "Fav2"), for: .normal)
        }
        cell.index = indexPath
        cell.transferToCartDelegate = self
        
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



//MARK:-TransferToCartDelegate

extension MyComparisonViewController : TransferToCartDelegate {
    func transferCart(index: Int) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "AddCartPopupViewController") as! AddCartPopupViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.idProduct = SharedCoreData.myComparisonArray[index].productid
        vc.addToCartAndGo = self
        self.present(vc, animated: true, completion: nil)
    }
    
}

//MARK:-AddToCartAndGo

extension MyComparisonViewController : AddToCartAndGo {
    func goToCart() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as? MyCartViewController {
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
            
        }
    }
    
    
}


