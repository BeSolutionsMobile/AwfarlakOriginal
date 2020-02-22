//
//  ProductDetails.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/21/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - ProductDetails
struct ProductDetails: Codable {
    let favorite, status: Int
    let id: String
    let image: String
    let album: [String]?
    let title, slug, productDetailsDescription, priceAfterDiscount: String
    let priceBeforeDiscount, discount: String
    let rating, quantity: Int
    let colors: [String]?
    let comments: [Comment]?
    let message: String?


    enum CodingKeys: String, CodingKey {
        case favorite, status, id, image, album, title, slug,message
        case productDetailsDescription = "description"
        case priceAfterDiscount = "price_after_discount"
        case priceBeforeDiscount = "price_before_discount"
        case discount, rating, quantity, colors, comments
    }
}

// MARK: - Comment
struct Comment: Codable {
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
