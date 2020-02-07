//
//  ThirdViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/6/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ThirdViewController: UIViewController {

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
            let vc = storyboard?.instantiateViewController(identifier: "SecondViewController") as! SecondViewController
            vc.modalPresentationStyle = .fullScreen
            presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromRight)
            
        } else if sender.direction == .left {
            let vc = storyboard?.instantiateViewController(identifier: "AwfarlakViewController") as! AwfarlakViewController
            vc.modalPresentationStyle = .fullScreen
            presentViewControllerWithTransition(viewController: vc, animated: true, direction: .fromLeft)
            
            
        }
    }
    
    
    
    @IBAction func enjoyShoppingBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "AwfarlakViewController") as? AwfarlakViewController {
                 vc.modalPresentationStyle = .fullScreen
                 present(vc, animated: true, completion: nil)
             }
    }
    
    @IBAction func backWellcomeBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
