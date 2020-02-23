//
//  FaQuestion.swift
//  AwfarlakOriginal
//
//  Created by Mustafa on 2/23/20.
//  Copyright © 2020 amirahmed. All rights reserved.
//

import Foundation

// MARK: - FaQuestion
struct FaQuestion: Codable {
    let status: Int
    let questions: [Question]?
    let message: String?

}

// MARK: - Question
struct Question: Codable {
    let id, title, questionDescription: String

    enum CodingKeys: String, CodingKey {
        case id, title
        case questionDescription = "description"
    }
}
