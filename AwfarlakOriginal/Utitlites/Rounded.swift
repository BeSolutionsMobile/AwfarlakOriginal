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
    
    static func simpleView(view: UIView){
        view.layer.maskedCorners = []
    }
    
    static func emptyData(collectionView: UICollectionView ,View: UIView ,MessageText: String) {
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: View.frame.width, height: View.frame.height))
        if collectionView.numberOfItems(inSection: 0) == 0 {
            errorView.tag = 100
            errorView.backgroundColor = .white
            
            let message = UILabel(frame: CGRect(x: errorView.frame.width/2 - 200
                , y: errorView.frame.height/2 , width: 400, height: 25))
            message.text = MessageText
            message.textColor = .darkGray
            message.textAlignment = .center
            message.font = UIFont(name: "Futura-Normal", size: 20)
            
        
            errorView.addSubview(message)
            View.addSubview(errorView)
        }
        else{
            if let viewWithTag = View.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
    
    static func emptyDataTable(TabelView: UITableView ,View: UIView ,MessageText: String) {
        let errorView = UIView(frame: CGRect(x: 0, y: 0, width: View.frame.width, height: View.frame.height))
        if TabelView.numberOfRows(inSection: 0) == 0 {
            errorView.tag = 100
            errorView.backgroundColor = .white
            
            
            let message = UILabel(frame: CGRect(x: errorView.frame.width/2 - 200
                , y: errorView.frame.height/2 , width: 400, height: 25))
            message.text = MessageText
            message.textColor = .darkGray
            message.textAlignment = .center
            message.font = UIFont(name: "Futura-Normal", size: 20)
            
        
            errorView.addSubview(message)
            View.addSubview(errorView)
        }
        else{
            if let viewWithTag = View.viewWithTag(100) {
                viewWithTag.removeFromSuperview()
            }
        }
    }
}



