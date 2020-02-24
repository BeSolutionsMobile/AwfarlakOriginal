//
//  ThirdViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/6/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH

class ThirdViewController: UIViewController {

    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var mainView: UIView!
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
        changeArrow()
        swipToRightAndLeft()
    }
    
    
    func changeArrow()  {
          if MOLHLanguage.currentAppleLanguage() == "en"{
              self.arrowBtn.setImage(UIImage(named: "backWellcome"), for: .normal)
          }
          else if  MOLHLanguage.currentAppleLanguage() == "ar"{
              self.arrowBtn.setImage(UIImage(named: "nextWellcome"), for: .normal)
            
          }
      }
    func swipToRightAndLeft(){
        let swipeToLeft = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeToLeft.direction = .left
        self.view.addGestureRecognizer(swipeToLeft)
        
        let swipeToRight = UISwipeGestureRecognizer(target: self, action: #selector(swipeAction(_:)))
        swipeToRight.direction = .right
        self.view.addGestureRecognizer(swipeToRight)
    }
    
    @objc func swipeAction(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .right {
            if MOLHLanguage.currentAppleLanguage() == "en"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "AwfarlakViewController") as! AwfarlakViewController
                vc.modalPresentationStyle = .fullScreen
                presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)                     }
            else if  MOLHLanguage.currentAppleLanguage() == "ar"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                vc.modalPresentationStyle = .fullScreen
                presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)
            }
            
            
            
            
        } else if sender.direction == .left {
            if MOLHLanguage.currentAppleLanguage() == "en"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
                vc.modalPresentationStyle = .fullScreen
                presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromLeft)
            }
            else if  MOLHLanguage.currentAppleLanguage() == "ar"{
                let vc = storyboard?.instantiateViewController(withIdentifier: "AwfarlakViewController") as! AwfarlakViewController
                vc.modalPresentationStyle = .fullScreen
                presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromLeft)
                
            }
            
            
            
           
            
        }
    }
    
    
    
    @IBAction func enjoyShoppingBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "AwfarlakViewController") as? AwfarlakViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func backWellcomeBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }    }
    
    
}
