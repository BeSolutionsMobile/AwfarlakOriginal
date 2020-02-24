//
//  AppDelegate.swift
//  I Am Rich
//
//  Created by Mustafa on 8/27/19.
//  Copyright © 2019 Mostafa. All rights reserved.
//

import UIKit
import CoreData
import MOLH
import IQKeyboardManager
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate,MOLHResetable {
    func reset() {
        let rootviewcontroller: UIWindow = ((UIApplication.shared.delegate?.window)!)!
        let stry = UIStoryboard(name: "Nav", bundle: nil)
        rootviewcontroller.rootViewController = stry.instantiateViewController(withIdentifier: "MainNavigationController")
    }
    
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        MOLH.shared.activate(true)
        IQKeyboardManager.shared().isEnabled = true
        
        let didLunchedBefore = UserDefaults.standard.bool(forKey: "didLunchedBefore")
        if !didLunchedBefore {
            UserDefaults.standard.set(true, forKey: "didLunchedBefore")
            UserDefaults.standard.synchronize()
            let storBoared = UIStoryboard(name: "Main", bundle: nil)
            let vc = storBoared.instantiateViewController(withIdentifier: "FristViewController") as! FristViewController
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController = vc
            
        }
        
        if  UserDefault.getcheckLogin() == true {
            let storBoared = UIStoryboard(name: "Nav", bundle: nil)
            let vc = storBoared.instantiateViewController(withIdentifier: "MainNavigationController")
            self.window?.makeKeyAndVisible()
            self.window?.rootViewController = vc
        }
        
        
        
        return true
    }
    
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
        
    }
    
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "MyAwfarlakDataModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}




