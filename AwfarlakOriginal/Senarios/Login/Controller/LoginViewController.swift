//
//  LoginViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/27/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var loginAnimation: UIView!
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var viewOpecity: UIView!
    @IBOutlet weak var headerImage: UIImageView!
    @IBOutlet weak var loginEmailTf: UITextField!{
        didSet{
            loginEmailTf.isSecureTextEntry = false
            loginEmailTf.delegate = self

        }
    }
    @IBOutlet weak var loginPasswordTf: UITextField!{
        didSet{
            loginPasswordTf.delegate = self
        }
    }
    
    //MARK: - Variables
    
    var login : Login?
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateDesign()
    }
    
    
    
    
    
    
    
    //MARK: - Func to  Update Design
    
    func updateDesign()  {
        headerImage.layer.cornerRadius = self.bigView.bounds.height * 0.29
        headerImage.layer.masksToBounds = true
        headerImage.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner  ]
        viewOpecity.layer.cornerRadius = self.bigView.bounds.height * 0.29
        viewOpecity.layer.masksToBounds = true
        viewOpecity.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner  ]
        loginAnimation.isHidden = true
    }
    
    //MARK: - Func to Login
    
    func getLogin()  {
        if validateLoginTfEmpty() {
            Services.login(email: loginEmailTf.text!, password: loginPasswordTf.text!, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.login = result
                    self.clearText()
                    self.setData()
                    self.startAnimation()
                case 2:
                    self.incorrectEmailOrPassword()
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
        
    }
    
    //MARK: - Func to incorrect Email or Password
    
    func incorrectEmailOrPassword() {
        CustomDesign.validateNotDone(textField: loginEmailTf, numberOfShakes: 3, revert: true)
        CustomDesign.validateNotDone(textField: loginPasswordTf, numberOfShakes: 3, revert: true)
        Alert.show("Error".localized, massege: "LoginMsg3".localized, context: self)
    }
    
    
    
    //MARK: - Func to Validation of Login Text Field Is Empty Or Not
    
    func validateLoginTfEmpty()->Bool {
        if let email = loginEmailTf.text , !email.isEmpty {
            if let pass = loginPasswordTf.text , !pass.isEmpty{
                return true
            }else{
                CustomDesign.validateNotDone(textField: loginPasswordTf, numberOfShakes: 3, revert: true)
                Alert.show("Error".localized, massege: "LoginMsg2".localized, context: self)
                return false
            }
        }else {
            CustomDesign.validateNotDone(textField: loginEmailTf, numberOfShakes: 3, revert: true)
            Alert.show("Error".localized, massege: "LoginMsg1".localized, context: self)
            return false
        }
    }
    
    //MARK: - Func to Set Date in UserDafault
    
    func setData() {
        UserDefault.setId((self.login?.userData?.id)!)
        UserDefault.setName((self.login?.userData?.name)!)
        UserDefault.setEmail((self.login?.userData?.mail)!)
        UserDefault.setPhone((self.login?.userData?.phone)!)
    }
 
    
    //MARK: - Func to Empty TextFaild
    
    func clearText()  {
        loginEmailTf.text = ""
        loginPasswordTf.text = ""
    }
    
    //MARK: - Func to Start Animation And Transfer To Main Home Page
    
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
    
    
    //MARK: - IBAction
    
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
        getLogin()
    }
    
}



