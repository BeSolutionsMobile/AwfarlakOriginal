//
//  SharedCoreData.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/23/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import CoreData

class SharedCoreData {
    static let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    static var myComparisonArray = [MyComparison]()
    static var myCartArray = [MyCart]()

    
    static func saveInAwfarlak(){
        do {
            try SharedCoreData.context.save()
        }catch {
             print("Error Saving  Context \(error)")
            
        }
    }
    
    static func loadMyComparison() {
        do{
            let request : NSFetchRequest<MyComparison> = MyComparison.fetchRequest()
            SharedCoreData.myComparisonArray = try SharedCoreData.context.fetch(request)
        }catch{
            print("Error Fetching Data From Context\(error)")
            
        }
    }
    
    static func deleteMyComparison()  {
          let request : NSFetchRequest<MyComparison> = MyComparison.fetchRequest()
          request.includesPropertyValues = false
          do {
              let items = try SharedCoreData.context.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
              
              for item in items {
                  SharedCoreData.context.delete(item)
              }
              try SharedCoreData.context.save()
          } catch {
              print("Error Delete Data From Context\(error)")
          }
      }
    
    static func loadMyCart() {
        do{
            let request : NSFetchRequest<MyCart> = MyCart.fetchRequest()
            SharedCoreData.myCartArray = try SharedCoreData.context.fetch(request)
        }catch{
            print("Error Fetching Data From Context\(error)")
            
        }
    }
    
    static func deleteMyCart()  {
          let request : NSFetchRequest<MyCart> = MyCart.fetchRequest()
          request.includesPropertyValues = false
          do {
              let items = try SharedCoreData.context.fetch(request as! NSFetchRequest<NSFetchRequestResult>) as! [NSManagedObject]
              
              for item in items {
                  SharedCoreData.context.delete(item)
              }
              try SharedCoreData.context.save()
          } catch {
              print("Error Delete Data From Context\(error)")
          }
      }
}



