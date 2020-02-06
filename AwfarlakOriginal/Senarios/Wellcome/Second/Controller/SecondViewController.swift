//
//  SecondViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/6/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class SecondViewController: UIViewController {
    
    @IBOutlet weak var anmView: UIView!
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
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var wellcomImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDesign()
        // Do any additional setup after loading the view.
    }
    
    
    func updateDesign(){
        mainView.layer.cornerRadius = self.bigView.bounds.height / 2
        mainView.layer.masksToBounds = true
        startAnimation()
        swipToRightAndLeft()
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
            let vc = storyboard?.instantiateViewController(identifier: "FristViewController") as! FristViewController
            vc.modalPresentationStyle = .fullScreen
            presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)
            
        } else if sender.direction == .left {
            let vc = storyboard?.instantiateViewController(identifier: "ThirdViewController") as! ThirdViewController
            vc.modalPresentationStyle = .fullScreen
            presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromLeft)
            
            
        }
    }
    
    
    
    func startAnimation(){
        wellcomImage.isHidden = true
        let view = StartAnimationView.showLottie(view: self.anmView, fileName: "shop", contentMode: .scaleAspectFit)
        view.play { (finished) in
            if finished {
                self.titleLbl.text = "You can also buy any of the products to get an enjoyable and pleasing shopping opportunity ."
                let view = StartAnimationView.showLottie(view: self.anmView, fileName: "cart", contentMode: .scaleAspectFit)
                view.play { (finished) in
                    if finished {
                        self.anmView.isHidden = true
                        self.titleLbl.text = " As you browse our products, you can view the statistics about the product and its ratings, and you can add it to your favorites list for your reference at any time.You can also buy any of the products to get an enjoyable and pleasing shopping opportunity ."
                        self.wellcomImage.isHidden = false
                    } else {
                        // Fallback on earlier versions
                    }
                    
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    @IBAction func nextBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ThirdViewController") as? ThirdViewController {
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


