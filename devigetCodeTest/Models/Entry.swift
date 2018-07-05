//
//  Entry.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import Foundation

class Entry: Codable {
    
    var id: String?
    var title: String?
    var author: String?
    var createdAt: Date?
    var thumbnail: String?
    var numOfcomments: Int?
    var fullImage: String?
    var read: Bool? = false
    var dismiss: Bool? = false
    
    enum CodingKeys: String, CodingKey {
        case id = "name"
        case title
        case author
        case thumbnail
        case numOfcomments = "num_comments"
        case createdAt = "created_utc"
        case fullImage = "url"
        case read
        case dismiss
    }
}
