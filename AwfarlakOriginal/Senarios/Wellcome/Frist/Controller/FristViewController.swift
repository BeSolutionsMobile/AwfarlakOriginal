//
//  FristViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/6/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH

class FristViewController: UIViewController {
    
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var shopingLbl: UILabel!
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var animationView: UIView!
    @IBOutlet weak var fristV: UIView!{
        didSet{
            fristV.layer.cornerRadius = fristV.frame.size.height/2
            fristV.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var secondV: UIView!{
        didSet{
            secondV.layer.cornerRadius = secondV.frame.size.height/2
            secondV.layer.masksToBounds = true
        }
    }
    @IBOutlet weak var thirdV: UIView!{
        didSet{
            thirdV.layer.cornerRadius = thirdV.frame.size.height/2
            thirdV.layer.masksToBounds = true
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDesign()
        
        // Do any additional setup after loading the view.
    }
    
    func updateDesign(){
        mainView.layer.cornerRadius = self.bigView.bounds.height / 2
        mainView.layer.masksToBounds = true
        startAnimation()
        changeArrow()
        swipToRight()
    }
    
    func changeArrow()  {
        if MOLHLanguage.currentAppleLanguage() == "en"{
            self.arrowBtn.setImage(UIImage(named: "nextWellcome"), for: .normal)
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            self.arrowBtn.setImage(UIImage(named: "backWellcome"), for: .normal)
        }
    }
    
    func swipToRight(){
        let swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeSuccessAction))
        if MOLHLanguage.currentAppleLanguage() == "en"{
            swipeToLeft.direction = .right
        }
        else if  MOLHLanguage.currentAppleLanguage() == "ar"{
            swipeToLeft.direction = .left
        }
        
        self.view.addGestureRecognizer(swipeToLeft)
        
    }
    
    @objc func swipeSuccessAction(){
        let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
        vc.modalPresentationStyle = .fullScreen
        presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)
        
        
    }
    
    
    
    func startAnimation(){
        
        self.animationView.isHidden = false
        shopingLbl.isHidden = true
        let view = StartAnimationView.showLottie(view: self.animationView, fileName: "welcome", contentMode: .scaleAspectFit)
        view.play { (finished) in
            if finished {
                self.shopingLbl.isHidden = false
                
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
   
    
    
    @IBAction func nextViewBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as? SecondViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func skipBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "AwfarlakViewController") as? AwfarlakViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
}
