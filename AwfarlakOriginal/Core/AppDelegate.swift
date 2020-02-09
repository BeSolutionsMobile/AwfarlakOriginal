//
//  AppDelegate.swift
//  AwfarlakOriginal
//
//  Created by mac on 1/27/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import MOLH

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
     
    
    func reset() {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: "Nav", bundle: nil)
        rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: "MainNavigationController")
    }

    @available(iOS 13.0, *)
       func swichRoot(){
           //Flip Animation before changing rootView
           animateView()

           // switch root view controllers
           let storyboard = UIStoryboard.init(name: "Nav", bundle: nil)
           let nav = storyboard.instantiateViewController(withIdentifier: "MainNavigationController")
           
           let scene = UIApplication.shared.connectedScenes.first
           if let sd : SceneDelegate = (scene?.delegate as? SceneDelegate) {
               sd.window!.rootViewController = nav
           }
           
       }
      @available(iOS 13.0, *)
       func animateView() {
           var transition = UIView.AnimationOptions.transitionFlipFromRight
           if !MOLHLanguage.isRTLLanguage() {
               transition = .transitionFlipFromLeft
           }
          animateView(transition: transition)
       }
       
       @available(iOS 13.0, *)
       func animateView(transition: UIView.AnimationOptions) {
           if let delegate = UIApplication.shared.connectedScenes.first?.delegate {
               UIView.transition(with: (((delegate as? SceneDelegate)!.window)!), duration: 0.5, options: transition, animations: {}) { (f) in
               }
           }
       }

  

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MOLH.shared.activate(true)
        MOLHLanguage.setDefaultLanguage("en")

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

