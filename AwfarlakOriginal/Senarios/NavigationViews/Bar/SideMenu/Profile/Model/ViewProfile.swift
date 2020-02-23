//
//  ViewProfile.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/22/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - ViewProfile
struct ViewProfile: Codable {
    let status: Int
    let user: User
    let message: String?
}

// MARK: - User
struct User: Codable {
    let id, name, mail, phone: String
    let image: String
}
