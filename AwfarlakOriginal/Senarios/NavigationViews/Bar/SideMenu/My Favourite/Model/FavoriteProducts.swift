//
//  FavoriteProducts.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/20/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - FavoriteProducts
struct FavoriteProducts: Codable {
    let status: Int
    var products: [FavoriteProduct]?
    let message: String?
}

// MARK: - Product
struct FavoriteProduct: Codable {
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
