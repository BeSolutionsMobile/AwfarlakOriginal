//
//  AwfarlakSideMenuViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH

class AwfarlakSideMenuViewController: UIViewController {
    
    //MARK: - IBOutlet

    @IBOutlet  var profileArrowMenu:[UIImageView]!
    @IBOutlet weak var langView: UIView!{
        didSet{
            langView.layer.cornerRadius = self.langView.frame.height/2
            langView.layer.masksToBounds = true
           
        }
    }
    @IBOutlet weak var circleView: UIView!{
        didSet{
            circleView.layer.cornerRadius = self.circleView.frame.height/2
            circleView.layer.borderWidth = 1
            circleView.layer.borderColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        }
    }
    @IBOutlet weak var profileView: UIImageView!
    @IBOutlet weak var profileName: UILabel!
    @IBOutlet weak var profileEmail: UILabel!
    @IBOutlet weak var firstSide: UIView!{
        didSet{
            firstSide.layer.cornerRadius = 20
            firstSide.clipsToBounds = true
        }
    }
    @IBOutlet weak var secondSide: UIView!{
        didSet{
            secondSide.layer.cornerRadius = 20
            secondSide.clipsToBounds = true
        }
    }
    
    //MARK: - Variables
       
       var viewProfile : ViewProfile?
       let menuItem = ConstantMenu()
    
    //MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewDesign()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Func to  Update Design

       func updateViewDesign() {
           CustomDesign.customCircleImage(image: profileView)
           chackArrowLang()
           getDataProfile()
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
        profileName.text = viewProfile?.user.name
        profileEmail.text = viewProfile?.user.mail
    }
    
    //MARK: - Func to Change Design According to the Language

    func chackArrowLang()  {
        let  number : Int = profileArrowMenu.count
        for i in 0..<number{
            if MOLHLanguage.currentAppleLanguage() == "en"{
                profileArrowMenu[i].image = UIImage(named: "arrowMenu")
            }
            else if  MOLHLanguage.currentAppleLanguage() == "ar"{
                profileArrowMenu[i].image = UIImage(named: "arrowMenuAr")
            }
        }
    }

    //MARK: - IBAction

    @IBAction func selectFromMenuBtnPressed(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: menuItem.controller1[sender.tag - 1] ) else { return  }
               self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func logOutBtnPresssed(_ sender: UIButton) {
        UserDefault.setcheckLogin(false)
        if let vc = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func changeLangBtnPressed(_ sender: UIButton) {
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
              MOLH.reset()
        
    }
    
}
