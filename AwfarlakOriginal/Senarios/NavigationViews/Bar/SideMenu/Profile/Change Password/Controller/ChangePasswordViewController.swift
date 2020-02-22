//
//  ChangePasswordViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/22/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var oldPasswordTf: UITextField!{
        didSet{
            oldPasswordTf.delegate = self
        }
    }
    @IBOutlet weak var newPasswordTf: UITextField!{
        didSet{
            newPasswordTf.delegate = self
        }
    }
    @IBOutlet weak var reNewPasswordTf: UITextField!{
        didSet{
            reNewPasswordTf.delegate = self
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()

        // Do any additional setup after loading the view.
    }
    
    
   
    @IBAction func showPassword(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            oldPasswordTf.isSecureTextEntry = !oldPasswordTf.isSecureTextEntry
        case 2:
            newPasswordTf.isSecureTextEntry = !newPasswordTf.isSecureTextEntry
        case 3:
            reNewPasswordTf.isSecureTextEntry = !reNewPasswordTf.isSecureTextEntry
        default:
            print("")
        }
        
    }
    @IBAction func changePasswordBtn(_ sender: UIButton) {
    }
    
}
