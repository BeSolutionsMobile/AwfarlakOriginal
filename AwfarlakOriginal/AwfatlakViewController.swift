//
//  ViewController.swift
//  AwfarlakOriginal
//
//  Created by mac on 1/27/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class AwfarlakViewController: UIViewController {

    @IBOutlet weak var awfarlakBgImage: UIImageView!{
        didSet{
            awfarlakBgImage.layer.cornerRadius = 25
            awfarlakBgImage.clipsToBounds = true
            awfarlakBgImage.layer.maskedCorners = [.layerMinXMinYCorner,.layerMaxXMinYCorner  ]
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

