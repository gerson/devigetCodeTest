//
//  LocalEntryRepository.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import Foundation

class LocalEntryRepository: BaseEntryRepository {
    
    static let shared = LocalEntryRepository()
    var entries: [Entry]?
    var count: Int {
        if let entries = self.entries {
            return entries.count
        } else { return 0 }
    }
    
    func getAll(_ completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
    func nextPage(identifier: String, completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
    func previousPage(identifier: String, completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
    func markedRead(entry: Entry, completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
    func dismiss(entry: Entry, completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
    func dismissAll(completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
}
