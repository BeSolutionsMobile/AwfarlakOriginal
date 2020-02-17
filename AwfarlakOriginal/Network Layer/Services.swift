//
//  Services.swift
//  Tigari
//
//  Created by Mustafa on 2/16/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import UIKit
import Alamofire


class Services {
    
    // MARK: - Register

    class func register(name: String, mail: String,phone : String,password : String, callback: @escaping (Register) -> Void, failureHandler: @escaping (Error) -> Void) {
        let url = URLs.registerURL
      let parameters = ["name": name,"mail" : mail,"phone" : phone, "password": password]
        //  let headers = ["Content-Type":"application/json"]
        Service.request(url: url, dateFormate: nil, method: HTTPMethod.post, parameters: parameters, headers:nil, callBack: { (response: Register ) in
          callback(response)
        }) { (error) in
            failureHandler(error)
        }
    }
    
    // MARK: - Register Failure

    class func registerFailure(name: String, mail: String,phone : String,password : String, callback: @escaping (Failure) -> Void, failureHandler: @escaping (Error) -> Void) {
           let url = URLs.registerURL
         let parameters = ["name": name,"mail" : mail,"phone" : phone, "password": password]
           Service.request(url: url, dateFormate: nil, method: HTTPMethod.post, parameters: parameters, headers:nil, callBack: { (response: Failure ) in
            callback(response)
           }) { (error) in
               failureHandler(error)
           }
       }
    
    // MARK: - Login

    class func login(email: String, password: String, callback: @escaping (Login) -> Void, failureHandler: @escaping (Error) -> Void) {
        let url = URLs.loginURL
        let parameters = ["mail": email, "password": password]
        Service.request(url: url, dateFormate: nil, method: HTTPMethod.post, parameters: parameters, headers:nil, callBack: { (response: Login) in
            callback(response)
        }) { (error) in
            failureHandler(error)
        }
    }
    
    // MARK: - ForgetPassword

       class func forgetPassword(email: String, callback: @escaping (ForgetPassword) -> Void, failureHandler: @escaping (Error) -> Void) {
           let url = URLs.forgetPasswordURL
           let parameters = ["mail": email]
           Service.request(url: url, dateFormate: nil, method: HTTPMethod.post, parameters: parameters, headers:nil, callBack: { (response: ForgetPassword) in
               callback(response)
           }) { (error) in
               failureHandler(error)
           }
       }
    
    
    
    
}












