//
//  Products.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/19/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - Products
struct Products: Codable {
    let status: Int
    var products: [Product]?
    let message: String?

}

// MARK: - Product
struct Product: Codable {
    let id, title, priceAfterDiscount, priceBeforeDiscount: String
    let discount: String
    let image: String
    let rating: String
    let favorite: Int

    enum CodingKeys: String, CodingKey {
        case id, title
        case priceAfterDiscount = "price_after_discount"
        case priceBeforeDiscount = "price_before_discount"
        case discount, image, rating, favorite
    }
}
