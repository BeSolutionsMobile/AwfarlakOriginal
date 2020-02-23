//
//  RegisterViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/28/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import BEMCheckBox
class RegisterViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var animationRegister: UIView!
    @IBOutlet var bigView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var iAgreeChk: BEMCheckBox!{
        didSet{
            self.iAgreeChk.boxType = .square
        }
    }
    @IBOutlet weak var fullNameTf: UITextField!{
        didSet{
            fullNameTf.delegate = self
            fullNameTf.isSecureTextEntry = false
        }
    }
    @IBOutlet weak var emailTf: UITextField!{
        didSet{
            emailTf.delegate = self
            emailTf.isSecureTextEntry = false
            
        }
    }
    @IBOutlet weak var phoneTf: UITextField!{
        didSet{
            phoneTf.delegate = self
            phoneTf.isSecureTextEntry = false
            
        }
    }
    @IBOutlet weak var passwordTf: UITextField!{
        didSet{
            passwordTf.delegate = self
        }
    }
    @IBOutlet weak var confirmPasswordTf: UITextField!{
        didSet{
            confirmPasswordTf.delegate = self
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
        mainView.layer.cornerRadius = self.bigView.bounds.height * 0.4
        mainView.layer.masksToBounds = true
    }
    
    //MARK: - Func to  Registration
    
    func getRegister()  {
        if validateRegister(){
            Services.register(name: fullNameTf.text! , mail: emailTf.text!, phone: phoneTf.text!, password: passwordTf.text!, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.getLogin()
                case 2:
                    Alert.show("Error".localized, massege: result.message, context: self)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    
    //MARK: - Func to Login After  Register
    
    func getLogin(){
        Services.login(email: emailTf.text!, password: passwordTf.text!, callback: { (result) in
            self.login = result
            print(result)
            switch result.status {
            case 1:
                self.login = result
                self.clearText()
                self.setData()
                self.startAnimation()
            default:
                print(result.status)
            }
        }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Func to Validation of Register
    
    func validateRegister()->Bool {
        if let  name = fullNameTf.text ,!name.isEmpty, let email = emailTf.text ,!email.isEmpty, let phone = phoneTf.text ,!phone.isEmpty, let pass = passwordTf.text,!pass.isEmpty,let confrimPass  = confirmPasswordTf.text , !confrimPass.isEmpty{
            if iAgreeChk.on == true {
                if name.count >= 4{
                    if emailIsValid(email) == true {
                        if phone.count >= 11 {
                            if pass.count >= 6 {
                                if confrimPass == pass {
                                    return true
                                }else {
                                    CustomDesign.validateNotDone(textField: confirmPasswordTf, numberOfShakes: 3, revert: true)
                                    Alert.show("Error".localized, massege: "RegisterMsg7".localized, context: self)
                                    return false
                                }
                            }else {
                                CustomDesign.validateNotDone(textField: passwordTf, numberOfShakes: 3, revert: true)
                                Alert.show("Error".localized, massege: "RegisterMsg6".localized, context: self)
                                return false
                            }
                        }else{
                            CustomDesign.validateNotDone(textField: phoneTf, numberOfShakes: 3, revert: true)
                            Alert.show("Error".localized, massege: "RegisterMsg5".localized, context: self)
                            return false
                        }
                    }else {
                        CustomDesign.validateNotDone(textField: emailTf, numberOfShakes: 3, revert: true)
                        Alert.show("Error".localized, massege: "RegisterMsg4".localized, context: self)
                        return false
                    }
                }else {
                    CustomDesign.validateNotDone(textField: fullNameTf, numberOfShakes: 3, revert: true)
                    Alert.show("Error".localized, massege: "RegisterMsg3".localized, context: self)
                    return false
                }
            }else{
                Alert.show("Error".localized, massege: "RegisterMsg2".localized, context: self)
                return false
            }
        }else {
            
            Alert.show("Error".localized, massege: "RegisterMsg1".localized, context: self)
            return false
        }
    }
    
    //MARK: - Func to Validation of Email
    
    func emailIsValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
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
        fullNameTf.text = ""
        emailTf.text = ""
        phoneTf.text = ""
        passwordTf.text = ""
        confirmPasswordTf.text = ""
    }
    
    //MARK: - Func to Start Animation And Transfer To Main Home Page
    
    func startAnimation(){
        animationRegister.isHidden = false
        let view = StartAnimationView.showLottie(view: self.animationRegister, fileName: "seccess", contentMode: .scaleAspectFit)
        view.play { (finished) in
            if finished {
                self.animationRegister.isHidden = true
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
    
    @IBAction func showPassowrdBtnPressed(_ sender: UIButton) {
        passwordTf.isSecureTextEntry = !passwordTf.isSecureTextEntry
    }
    
    @IBAction func showConfirmPasswordBtnPressed(_ sender: UIButton) {
        confirmPasswordTf.isSecureTextEntry = !confirmPasswordTf.isSecureTextEntry
        
    }
    
    @IBAction func goToLoginBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true, completion: nil)
        }
    }
    @IBAction func createAccountBtnPreesed(_ sender: UIButton) {
        getRegister()
    }
}


