//
//  EntriesResponse.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import Foundation

struct TopEntriesResponse: Codable {
    
    var data: EntryList
    
    struct EntryList: Codable {
        var children: [ChildrenResponse]
    }
    
    struct ChildrenResponse: Codable {
        let data: Entry
    }
}
