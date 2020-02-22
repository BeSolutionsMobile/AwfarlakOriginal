//
//  Register.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/15/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation
// MARK: - Register
struct Register: Codable {
    let status: Int
    let message: String
    let idUser: String?
    enum CodingKeys: String, CodingKey {
        case status
        case idUser = "id_user"
        case message
    }
}
