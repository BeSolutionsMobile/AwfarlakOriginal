//
//  ChangePasswordViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/22/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ChangePasswordViewController: UIViewController  , NVActivityIndicatorViewable{
    
    //MARK: - IBOutlet
    
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
    
    //MARK: - Variables
    
    var changePassword : ChangePassword?
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        
        // Do any additional setup after loading the view.
    }
    

    override func viewDidAppear(_ animated: Bool) {
          super.viewDidAppear(true)
          showAndBacNavigation()
      }
    
    //MARK: - Func to Change Password
    
    func getChangePassword()  {
        if validatePassword() {
            self.startAnimating()
            Services.changePassword(oldPassword: oldPasswordTf.text!, newPassword: newPasswordTf.text!, reNewPassword: reNewPasswordTf.text!, idUser: UserDefault.getId(), callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.changePassword = result
                    Alert.show("Success".localized, massege: "ChangePass5".localized, context: self)
                    self.clearText()
                    self.stopAnimating()
                case 2:
                    Alert.show("Error".localized, massege: result.message, context: self)
                    self.stopAnimating()
                default:
                    print(result.status)
                    self.stopAnimating()
                }
            }) { (error) in
                print(error.localizedDescription)
                self.stopAnimating()
            }
        }
        
    }
    
    //MARK: - Func to Validation Password
    
    func validatePassword()->Bool {
        if let  oldPass = oldPasswordTf.text ,!oldPass.isEmpty, let newPass = newPasswordTf.text ,!newPass.isEmpty, let reNewPass = reNewPasswordTf.text ,!reNewPass.isEmpty{
            if oldPass.count >= 6{
                if newPass.count >= 6 {
                    if reNewPass.count >= 6 {
                        if newPass == reNewPass {
                            return true
                        }else {
                            Alert.show("Error".localized, massege: "ChangePass4".localized, context: self)
                            return false
                        }
                    }else{
                        Alert.show("Error".localized, massege: "ChangePass3".localized, context: self)
                        return false
                    }
                }else {
                    Alert.show("Error".localized, massege: "ChangePass2".localized, context: self)
                    return false
                }
            }else {
                Alert.show("Error".localized, massege: "ChangePass1".localized, context: self)
                return false
            }
        }else{
            Alert.show("Error".localized, massege: "ChangePass6".localized, context: self)
            return false
        }
    }
    
    //MARK: - Func to Empty TextFaild
    
    func clearText()  {
        oldPasswordTf.text = ""
        newPasswordTf.text = ""
        reNewPasswordTf.text = ""
    }
    
    //MARK: - IBAction
    
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
        getChangePassword()
    }
    
}
