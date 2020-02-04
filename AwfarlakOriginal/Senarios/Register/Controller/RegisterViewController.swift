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
        }
    }
    @IBOutlet weak var emailTf: UITextField!{
        didSet{
            emailTf.delegate = self
        }
    }
    @IBOutlet weak var phoneTf: UITextField!{
        didSet{
            phoneTf.delegate = self
        }
    }
    @IBOutlet weak var passwordTf: UITextField!{
        didSet{
            passwordTf.delegate = self
            passwordTf.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var confirmPasswordTf: UITextField!{
        didSet{
            confirmPasswordTf.delegate = self
            confirmPasswordTf.isSecureTextEntry = true

        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateDesign()
    }
    
    
    
    func updateDesign()  {
        mainView.layer.cornerRadius = self.bigView.bounds.height * 0.4
        mainView.layer.masksToBounds = true
       
    }
    
    
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
    }
}


