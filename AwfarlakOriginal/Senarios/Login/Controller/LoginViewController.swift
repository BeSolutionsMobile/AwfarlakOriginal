//
//  LoginViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/27/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var viewOpecity: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var loginEmailTf: UITextField!{
        didSet{
           loginEmailTf.delegate = self
        }
    }
    @IBOutlet weak var loginPasswordTf: UITextField!{
        didSet{
           loginPasswordTf.delegate = self
           loginPasswordTf.isSecureTextEntry = true
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDesign()
    }
    
    
    
    func updateDesign()  {
        headerImage.layer.cornerRadius = self.bigView.bounds.height * 0.29
        headerImage.layer.masksToBounds = true
        headerImage.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner  ]
        viewOpecity.layer.cornerRadius = self.bigView.bounds.height * 0.29
        viewOpecity.layer.masksToBounds = true
        viewOpecity.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner  ]
        
    }
    
    @IBAction func showPasswordBtnPressed(_ sender: UIButton) {
        loginPasswordTf.isSecureTextEntry = !loginPasswordTf.isSecureTextEntry
        
    }
    
    
    @IBAction func forgotPasswordBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ForgotPasswordViewController") as? ForgotPasswordViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func dontHaveAccountBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "RegisterViewController") as? RegisterViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func loginBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "MainNavigationController") as? MainNavigationController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    
}



