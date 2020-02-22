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
    
   
    @IBAction func editBtnPressed(_ sender: UIButton) {
    }
    
    
    @IBAction func changePassordBtnPressed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "ChangePasswordViewController") as? ChangePasswordViewController {
                   vc.modalPresentationStyle = .fullScreen
                   navigationController?.pushViewController(vc, animated: true)
               }
    }
}


