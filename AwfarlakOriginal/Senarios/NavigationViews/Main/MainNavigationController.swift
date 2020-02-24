//
//  MainNavigationController.swift
//  Konsil
//
//  Created by Ali Mohamed on 12/16/19.
//  Copyright © 2019 begroup. All rights reserved.
//

import UIKit
import SideMenu
import MOLH
import CoreData

class MainNavigationController: UINavigationController  {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension UIViewController {
    func showNavigation() {
        navigationItem.hidesBackButton = true
        let menu = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(menuBtn))
        menu.image = UIImage(named: "menu")
        menu.tintColor = UIColor.white
        let cartButton = SSBadgeButton()
        cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        cartButton.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cartButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        cartButton.tintColor = UIColor.white
        cartButton.addTarget(self, action: #selector(cartBtn), for: .touchUpInside)
        SharedCoreData.loadMyCart()
        var number : String = String(SharedCoreData.myCartArray.count)
        cartButton.badge = number
        let search = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(searchBtn))
        search.image = UIImage(named: "search")
        search.tintColor = UIColor.white
        
        self.navigationItem.rightBarButtonItems = [menu,UIBarButtonItem(customView: cartButton),search]
        
        
    }
    
    func showAndBacNavigation() {
        navigationItem.hidesBackButton = true
        let menu = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(menuBtn))
        menu.image = UIImage(named: "menu")
        menu.tintColor = UIColor.white
        let cartButton = SSBadgeButton()
        cartButton.frame = CGRect(x: 0, y: 0, width: 44, height: 44)
        cartButton.setImage(UIImage(named: "cart")?.withRenderingMode(.alwaysTemplate), for: .normal)
        cartButton.badgeEdgeInsets = UIEdgeInsets(top: 20, left: 0, bottom: 0, right: 15)
        cartButton.tintColor = UIColor.white
        cartButton.addTarget(self, action: #selector(cartBtn), for: .touchUpInside)
        SharedCoreData.loadMyCart()
        var number : String = String(SharedCoreData.myCartArray.count)
        cartButton.badge = number
        let search = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(searchBtn))
        search.image = UIImage(named: "search")
        search.tintColor = UIColor.white
        self.navigationItem.rightBarButtonItems = [menu,UIBarButtonItem(customView: cartButton),search]
        let back = UIBarButtonItem(title: "", style: .done,target: self, action: #selector(backBtn))
        if MOLHLanguage.currentAppleLanguage() == "en"{
                 back.image = UIImage(named: "back")
             }
             else if  MOLHLanguage.currentAppleLanguage() == "ar"{
                 back.image = UIImage(named: "backAr")
             }
        back.tintColor = UIColor.white
        navigationItem.leftBarButtonItem = back
        
        
    }
   
    
    
    @objc func menuBtn(){
            let vc = storyboard?.instantiateViewController(withIdentifier: "SideMenuNavigationController") as! SideMenuNavigationController
            vc.settings = SharedMenu.settings(view: self.view)
            present(vc, animated: true, completion: nil)

        
        
        
    }
    
    
    @objc func cartBtn(){
                    let vc = storyboard?.instantiateViewController(withIdentifier: "MyCartViewController") as! MyCartViewController
                    navigationController?.pushViewController(vc, animated: true)
        
        
        
        
    }
    
    
    @objc func searchBtn(){
        let screen = storyboard?.instantiateViewController(withIdentifier: "SearchViewController") as? SearchViewController
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        transition.subtype = CATransitionSubtype.fromBottom
        view.window!.layer.add(transition, forKey: kCATransition)
        screen!.modalPresentationStyle = .overFullScreen
        screen!.d = self
        self.present(screen!, animated: false, completion: nil)
    }
    
    @objc func backBtn(){
        navigationController?.popViewController(animated: true)
        
    }
    
    func presentViewControllerWithTransition(viewController: UIViewController ,animated: Bool ,direction: CATransitionSubtype ){
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.fade
        transition.subtype = direction
        transition.timingFunction = CAMediaTimingFunction(name:CAMediaTimingFunctionName.easeInEaseOut)
        view.window!.layer.add(transition, forKey: kCATransition)
        present(viewController, animated: animated, completion: nil)
    }
}



extension UIViewController : SearchProductDelegate {
    func transferResultProduct(text: String) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductsViewController") as! ProductsViewController
        vc.sender = 2
        vc.searchText = text
        vc.modalPresentationStyle = .fullScreen
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
