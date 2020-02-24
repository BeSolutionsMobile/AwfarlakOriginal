//
//  Search.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/24/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - Search
struct Search: Codable {
    let status: Int
    let products: [ProductSearch]?
    let message: String?

}

// MARK: - Product
struct ProductSearch: Codable {
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
