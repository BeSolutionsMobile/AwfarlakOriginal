//
//  ForgotPasswordViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/30/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {

    @IBOutlet var bigView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var emailTf: UITextField!{
        didSet{
            emailTf.delegate = self
        }
    }
    @IBOutlet weak var backToLogin: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDesign()

        // Do any additional setup after loading the view.
    }
    

    func updateDesign()  {
         mainView.layer.cornerRadius = self.bigView.bounds.height * 0.4
         mainView.layer.masksToBounds = true
        
     }

    @IBAction func backToLoginBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendNewPasswordBtnPressed(_ sender: UIButton) {
    }
}



