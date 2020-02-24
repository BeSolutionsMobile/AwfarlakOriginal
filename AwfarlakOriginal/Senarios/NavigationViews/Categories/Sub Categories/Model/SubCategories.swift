//
//  SubCategories.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/19/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - SubCategories
struct SubCategories: Codable {
    let catrgories: [SubCatrgory]?
    let status: Int
    let message: String?

}

// MARK: - Catrgory
struct SubCatrgory: Codable {
    let id, name: String
    let image: String
    let adv: String
}
