//
//  Login.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/16/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - Login
struct Login: Codable {
    let status: Int
    let message: String
    let userData: UserData
    
    enum CodingKeys: String, CodingKey {
        case status, message
        case userData = "user_data"
    }
}

// MARK: - UserData
struct UserData: Codable {
    let id, name, mail, password: String
    let phone, photo, address: String
    let gender: String?
    let jobType, cityID, userLanguage, verified: String
    let status, created, date, deleted: String
    let  lastUpdatedBy: String
    let createdBy : String?
    
    enum CodingKeys: String, CodingKey {
        case id, name, mail, password, phone, photo, address, gender
        case jobType = "job_type"
        case cityID = "city_id"
        case userLanguage = "user_language"
        case verified, status, created, date, deleted
        case createdBy = "created_by"
        case lastUpdatedBy = "last_updated_by"
    }
}


