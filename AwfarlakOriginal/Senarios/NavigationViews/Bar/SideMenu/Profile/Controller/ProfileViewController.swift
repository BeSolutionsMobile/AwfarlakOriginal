//
//  ProfileViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
    
    //MARK: - IBOutlet
    
    @IBOutlet weak var headerView: UIView!{
        didSet{
            headerView.layer.cornerRadius = headerView.frame.size.height / 2
            headerView.clipsToBounds = true
            headerView.layer.maskedCorners = [.layerMinXMaxYCorner,.layerMaxXMaxYCorner  ]
            
        }
    }
    @IBOutlet weak var cricleView: UIView!{
        didSet{
            cricleView.layer.cornerRadius = self.cricleView.frame.height/2
            cricleView.layer.borderWidth = 1
            cricleView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    @IBOutlet weak var changePhoto: UIButton!
    @IBOutlet weak var profilePhoto: UIImageView!
    @IBOutlet weak var fullNameTf: UITextField!{
        didSet{
            fullNameTf.isSecureTextEntry = false
            fullNameTf.delegate = self
            
        }
    }
    @IBOutlet weak var emailTf: UITextField!{
        didSet{
            emailTf.isSecureTextEntry = false
            emailTf.delegate = self
            
        }
    }
    @IBOutlet weak var phoneTf: UITextField!{
        didSet{
            phoneTf.isSecureTextEntry = false
            phoneTf.delegate = self
            
        }
    }
    
    //MARK: - Variables
    
    var editProfile : EditProfile?
    var viewProfile : ViewProfile?

    
    
    
    //MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateViewDesign()
      
        
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Func to  Update Design
    
    func updateViewDesign() {
        
        CustomDesign.customCircleImage(image: profilePhoto)
        CustomDesign.cricleButtonDesign(btn: changePhoto)
        getDataProfile()
    }
    
    //MARK: - Func to Edit Profile
    
    func getEditProfile()  {
        if validateProfile() {
            Services.editProfile(name: fullNameTf.text!, email: emailTf.text!, phone: phoneTf.text!, idUser: UserDefault.getId(), callback: { (result) in
                print(result)
                switch result.status {
                case 1:
                    self.editProfile = result
                    Alert.show("Success".localized, massege: "Profile4".localized, context: self)
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
    
    //MARK: - Func to Get Data Profile
       
       func getDataProfile()  {
        Services.getDataOfUser(idUser: UserDefault.getId(), callback: { (result) in
                   print(result)
                   switch result.status {
                   case 1:
                       self.viewProfile = result
                       self.getData()
                   case 2:
                    Alert.show("Error".localized, massege: result.message!, context: self)
                   default:
                       print(result.status)
                   }
               }) { (error) in
                   print(error.localizedDescription)
               }
           
       }
    
    //MARK: - Func to Get Date in View
    
    func getData() {
        fullNameTf.text = viewProfile?.user.name
        emailTf.text = viewProfile?.user.mail
        phoneTf.text = viewProfile?.user.phone

    }
    
    //MARK: - Func to Validation Profile

    func validateProfile()->Bool {
        if let  name = fullNameTf.text ,!name.isEmpty, let email = emailTf.text ,!email.isEmpty, let phone = phoneTf.text ,!phone.isEmpty{
            if name.count >= 4{
                if emailIsValid(email) == true {
                    if phone.count >= 11 {
                        return true
                    }else{
                        Alert.show("Error".localized, massege: "Profile3".localized, context: self)
                        return false
                    }
                }else {
                    Alert.show("Error".localized, massege: "Profile2".localized, context: self)
                    return false
                }
            }else {
                Alert.show("Error".localized, massege: "Profile1".localized, context: self)
                return false
            }
        }else{
            return false
        }
    }
    
    
    //MARK: - Func to Validation of Email
    
    func emailIsValid(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    
    //MARK: - IBOutlet

    @IBAction func changPhotoBtnPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func editBtnPressed(_ sender: UIButton) {
        getEditProfile()
    }
    
    
    @IBAction func changePassordBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ChangePasswordViewController") as? ChangePasswordViewController {
            vc.modalPresentationStyle = .fullScreen
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}


