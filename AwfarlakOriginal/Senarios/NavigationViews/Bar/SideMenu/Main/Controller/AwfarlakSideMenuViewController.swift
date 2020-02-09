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
    let menuItem = ConstantMenu()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateViewDesign()

        // Do any additional setup after loading the view.
    }
       func updateViewDesign() {
           CustomDesign.customCircleImage(image: profileView)
        chackArrowLang()
        
       }
    
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

    @IBAction func selectFromMenuBtnPressed(_ sender: UIButton) {
        guard let vc = storyboard?.instantiateViewController(identifier: menuItem.controller1[sender.tag - 1] ) else { return  }
               self.navigationController?.pushViewController(vc, animated: false)
    }
    @IBAction func logOutBtnPresssed(_ sender: UIButton) {
        if let vc = storyboard?.instantiateViewController(identifier: "LoginViewController") as? LoginViewController {
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    @IBAction func changeLangBtnPressed(_ sender: UIButton) {
        
        MOLH.setLanguageTo(MOLHLanguage.currentAppleLanguage() == "en" ? "ar" : "en")
        if #available(iOS 13.0, *) {
                let delegate = UIApplication.shared.delegate as? AppDelegate
                delegate!.swichRoot()
        } else {
               // Fallback on earlier versions
               MOLH.reset()
        }
    }
    
}
