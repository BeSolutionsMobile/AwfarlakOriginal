//
//  Categories.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/18/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - Categories
struct Categories: Codable {
    let catrgories: [MainCatrgory]?
    let status: Int
    let message: String?

}

// MARK: - Catrgory
struct MainCatrgory: Codable {
    let id, name: String
    let image, adv: String
}
