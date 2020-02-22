//
//  ProductComments.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/22/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - ProductComments
struct ProductComments: Codable {
    let status: Int
    let comments: [AllComment]?
    let message: String?
    
}

// MARK: - Comment
struct AllComment: Codable {
    let id, comment, userName: String
    let userPhoto: String
    let date: String

    enum CodingKeys: String, CodingKey {
        case id, comment
        case userName = "user_name"
        case userPhoto = "user_photo"
        case date
    }
}
