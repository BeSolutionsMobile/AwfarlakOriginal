//
//  AboutUsViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/5/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {
    
    @IBOutlet weak var aboutView: UIView!{
        didSet{
            aboutView.layer.cornerRadius = 25
            aboutView.clipsToBounds = true
        }
    }
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var lineWidth: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateViewDesign()
        
        // Do any additional setup after loading the view.
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        showAndBacNavigation()
    }
    
    
    func updateViewDesign() {
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.navigationBar.shadowImage = UIImage()
        lineWidth.constant = bigView.frame.width/2
        
        
    }
}
