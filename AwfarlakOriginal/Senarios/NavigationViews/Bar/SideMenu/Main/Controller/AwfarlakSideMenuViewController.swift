//
//  AwfarlakSideMenuViewController.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/1/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class AwfarlakSideMenuViewController: UIViewController {

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
}
