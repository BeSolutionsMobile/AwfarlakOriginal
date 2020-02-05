//
//  CusstomButton.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/27/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit

class CusstomButton: UIButton {
    override func awakeFromNib() {
        super.awakeFromNib()
        setUpUiview()
    }
    
    func setUpUiview()  {
        self.layer.cornerRadius = self.frame.size.height / 2
        self.clipsToBounds = false
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowOpacity = 0.8
        self.layer.shadowRadius = 6.0
    }


}
