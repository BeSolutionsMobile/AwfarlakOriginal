//
//  MyCartViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH

class MyCartViewController: UIViewController {
    
    @IBOutlet weak var myCartAnimationFavView: UIView!
    @IBOutlet weak var myCartTableView: UITableView!{
        didSet{
            myCartTableView.rowHeight = 230
        }
    }
    @IBOutlet weak var totalPrice: UILabel!
    @IBOutlet weak var completeOrderBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateViewDesign()
        
        // Do any additional setup after loading the view.
    }
    
    func updateViewDesign() {
        totalPrice.attributedText = NSAttributedString.withDualText2(text1: "rs".localized, ofSizeText1: 20, text2: "21.50", ofSizeText2: 20)
          myCartAnimationFavView.isHidden = true
         chkDesignBtn()
        
    }
    
    func chkDesignBtn()  {
        if MOLHLanguage.currentAppleLanguage() == "en"{
            completeOrderBtn.layer.cornerRadius = completeOrderBtn.frame.size.height / 2
            completeOrderBtn.clipsToBounds = true
            completeOrderBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
            callBtn.layer.cornerRadius = callBtn.frame.size.height / 2
            callBtn.clipsToBounds = true
            callBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            completeOrderBtn.layer.cornerRadius = completeOrderBtn.frame.size.height / 2
            completeOrderBtn.clipsToBounds = true
            completeOrderBtn.layer.maskedCorners = [.layerMinXMinYCorner,.layerMinXMaxYCorner  ]
            callBtn.layer.cornerRadius = callBtn.frame.size.height / 2
            callBtn.clipsToBounds = true
            callBtn.layer.maskedCorners = [.layerMaxXMinYCorner,.layerMaxXMaxYCorner  ]
            
        }
        
    }
    
    
    
    
    @IBAction func callBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func complteOrderBtnPressed(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "OrderSuccessfulViewController") as! OrderSuccessfulViewController
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true, completion: nil)
        
        //navigationController?.pushViewController(vc, animated: true)
    }
}

extension MyCartViewController : UITableViewDelegate , UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCartTableViewCell", for: indexPath) as! MyCartTableViewCell
        cell.oldPriceLbl.attributedText = "Rs.3.75/KG".strikeThrough()

        cell.delegate = self
        
        return cell
    }
    
    
    
    //MARK:- didSelectRowAt
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
    }
    
    
    
}




extension MyCartViewController : FavAnimationDelegate {
    func startFavAnimation() {
        myCartAnimationFavView.isHidden = false
        let view = StartAnimationView.showLottie(view: self.myCartAnimationFavView, fileName: "fav", contentMode: .scaleAspectFit)
        view.animationSpeed = 0.8
        view.play { (finished) in
            if finished {
                self.myCartAnimationFavView.isHidden = true
                
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    
}
