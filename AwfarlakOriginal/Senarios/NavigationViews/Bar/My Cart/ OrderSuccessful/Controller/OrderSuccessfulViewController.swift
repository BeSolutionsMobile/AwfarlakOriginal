//
//  OrderSuccessfulViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/5/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class OrderSuccessfulViewController: UIViewController {

    @IBOutlet weak var orderAnimationView: UIView!
    @IBOutlet weak var orderSuccessLbl: UILabel!{
        didSet{
            orderSuccessLbl.layer.cornerRadius = orderSuccessLbl.frame.size.height/2
            orderSuccessLbl.clipsToBounds = true
        }
    }
    @IBOutlet weak var enjoyLbl: UILabel!
    @IBOutlet weak var headerImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        startAnimation()

    }
    

  
    func startAnimation()  {

        self.orderAnimationView.isHidden = false
        let view = StartAnimationView.showLottie(view: self.orderAnimationView, fileName: "orderSuccess", contentMode: .scaleAspectFit)
        view.play { (finished) in
            if finished {
                self.orderAnimationView.isHidden = true
             self.dismiss(animated: true, completion: nil)
                } else {
                    // Fallback on earlier versions
                }
                
            }
        }
    
    

}
