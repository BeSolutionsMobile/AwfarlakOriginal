//
//  ForgotPasswordViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/30/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    //MARK: - IBOutlet

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
    
    
    //MARK: - Func to  Update Design

    func updateDesign()  {
        mainView.layer.cornerRadius = self.bigView.bounds.height * 0.4
        mainView.layer.masksToBounds = true
        
    }
    
    //MARK: - Func to Forgot Password
    
    func getForgotPassword(){
        if validateForgotPasswordTfEmpty(){
            Services.forgetPassword(email: emailTf.text!, callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.clearText()
                    Alert.show("Success".localized, massege: "ForgetPasswordMsg3".localized, context: self)
                case 2:
                    CustomDesign.validateNotDone(textField: self.emailTf, numberOfShakes: 3, revert: true)
                    Alert.show("Error".localized, massege: "ForgetPasswordMsg4".localized, context: self)
                default:
                    print(result.status)
                }
            }) { (error) in
                print(error.localizedDescription)
            }
        }
    }
    
    
    
   
    
    
    
    //MARK: - Func to Validation of Forgot Password Text Field Is Empty Or Not
    
    func validateForgotPasswordTfEmpty()->Bool {
        if let email = emailTf.text , !email.isEmpty {
            if emailIsValid(email){
                return true
            }else {
                CustomDesign.validateNotDone(textField: emailTf, numberOfShakes: 3, revert: true)
                Alert.show("Error".localized, massege: "ForgetPasswordMsg2".localized, context: self)
                return false
            }
        }else {
            CustomDesign.validateNotDone(textField: emailTf, numberOfShakes: 3, revert: true)
            Alert.show("Error".localized, massege: "ForgetPasswordMsg1".localized, context: self)
            return false
        }
    }
    
    //MARK: - Func to Validation of Email
    
    func emailIsValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    //MARK: - Func to Empty TextFaild
       
       func clearText()  {
           emailTf.text = ""
       }
    
    
    //MARK: - IBAction

    @IBAction func backToLoginBtnPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func sendNewPasswordBtnPressed(_ sender: UIButton) {
        getForgotPassword()
    }
}



