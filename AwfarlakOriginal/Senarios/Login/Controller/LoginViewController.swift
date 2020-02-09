//
//  LoginViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/27/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var loginAnimation: UIView!
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
    
    
    func startAnimation(){
       loginAnimation.isHidden = false
        let view = StartAnimationView.showLottie(view: self.loginAnimation, fileName: "seccess", contentMode: .scaleAspectFit)
        view.play { (finished) in
            if finished {
                self.loginAnimation.isHidden = true
                if let vc = self.storyboard?.instantiateViewController(identifier: "MainNavigationController") as? MainNavigationController {
                    vc.modalPresentationStyle = .fullScreen
                    self.present(vc, animated: true, completion: nil)
                }
            } else {
                // Fallback on earlier versions
            }
            
        }
    }
    
    
    func updateDesign()  {
        headerImage.layer.cornerRadius = self.bigView.bounds.height * 0.29
        headerImage.layer.masksToBounds = true
        headerImage.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner  ]
        viewOpecity.layer.cornerRadius = self.bigView.bounds.height * 0.29
        viewOpecity.layer.masksToBounds = true
        viewOpecity.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner  ]
        loginAnimation.isHidden = true

        
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
         startAnimation()
    }
    
}



