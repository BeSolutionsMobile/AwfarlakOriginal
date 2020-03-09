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
    let id, idOffer, comment, createdBy: String
    let lastUpdatedBy, status, deleted, created: String
    let updatedAt: String

    enum CodingKeys: String, CodingKey {
        case id
        case idOffer = "id_offer"
        case comment
        case createdBy = "created_by"
        case lastUpdatedBy = "last_updated_by"
        case status, deleted, created
        case updatedAt = "updated_at"
    }
}

