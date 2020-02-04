//
//  ProfileViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

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
    @IBOutlet weak var fullNameTf: UITextField!
    @IBOutlet weak var emailTf: UITextField!
    @IBOutlet weak var phoneTf: UITextField!
    @IBOutlet weak var passwordTf: UITextField!{
        didSet{
            passwordTf.delegate = self
            passwordTf.isSecureTextEntry = true
        }
    }
    @IBOutlet weak var addressTf: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showAndBacNavigation()
        updateViewDesign()

        // Do any additional setup after loading the view.
    }
    
    
    func updateViewDesign() {
        
        CustomDesign.customCircleImage(image: profilePhoto)
        CustomDesign.cricleButtonDesign(btn: changePhoto)
    }
    @IBAction func changPhotoBtnPressed(_ sender: UIButton) {
    }
    
    @IBAction func showPassword(_ sender: UIButton) {
        passwordTf.isSecureTextEntry = !passwordTf.isSecureTextEntry
    }
    @IBAction func editBtnPressed(_ sender: UIButton) {
    }
    
}


