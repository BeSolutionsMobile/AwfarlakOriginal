//
//  CustemDesign.swift
//  Dr.Nour
//
//  Created by Mustafa on 12/15/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit

class CustomDesign {
    
    
    static func cricleViewDesign(view : UIView) {
        view.layer.cornerRadius = view.frame.size.height/2
        view.clipsToBounds = true
    }
    
    static func customViewTextFaild(view : UIView) {
        view.layer.cornerRadius = 8
        view.layer.borderWidth = 0.3
        view.clipsToBounds = true
    }
    static func customTextFaild(textField : UITextField) {
        textField.layer.cornerRadius = 8
        textField.layer.borderWidth = 0.3
        textField.clipsToBounds = true
    }
    static func customCircleImage(image : UIImageView) {
        image.layer.cornerRadius = image.frame.size.height/2
        image.clipsToBounds = true
    }
    
    static func cricleButtonDesign(btn  : UIButton) {
        btn.layer.cornerRadius = btn.frame.size.height/2
        btn.clipsToBounds = true
        
    }
    static func criclLableDesign(lable  : UILabel) {
        lable.layer.cornerRadius = lable.frame.size.height/2
        lable.clipsToBounds = true
        
    }
    
    
    
}
