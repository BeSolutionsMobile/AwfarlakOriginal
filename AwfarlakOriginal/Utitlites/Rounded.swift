//
//  Rounded.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 1/30/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation
import UIKit

struct RoundedCollection {
static func topLeft(view: UIView){
    view.layer.cornerRadius = 25
    view.clipsToBounds = true
    view.layer.maskedCorners = .layerMinXMinYCorner
}

static func topRight(view: UIView){
    view.layer.cornerRadius = 25
    view.clipsToBounds = true
    view.layer.maskedCorners = .layerMaxXMinYCorner
}

static func bootemLeft(view: UIView){
    view.layer.cornerRadius = 25
    view.clipsToBounds = true
    view.layer.maskedCorners = .layerMinXMaxYCorner
}

static func bootemRight(view: UIView){
    view.layer.cornerRadius = 25
    view.clipsToBounds = true
    view.layer.maskedCorners = .layerMaxXMaxYCorner
}

}



