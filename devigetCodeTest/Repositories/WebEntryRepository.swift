//
//  WebEntryRepository.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import Foundation

class WebEntryRepository: BaseEntryRepository {
    
    static let shared = WebEntryRepository()
    var entries: [Entry]?
    var count: Int {
        if let entries = self.entries {
            return entries.count
        } else { return 0 }
    }
    
    func getAll(_ completion: @escaping BaseEntryRepository.Completion) {
        let service = EntryService()
        service.getTopEntries(after: nil, before: nil) {[unowned self] (entriesData, errorMessage) in
            guard errorMessage == nil || (errorMessage?.isEmpty)! else {
                return
            }
            self.entries = entriesData
            completion()
        }
    }
    
    func nextPage(identifier: String, completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
    func previousPage(identifier: String, completion: @escaping BaseEntryRepository.Completion) {
        
    }
    
    func markedRead(entry: Entry, completion: @escaping BaseEntryRepository.Completion) {
        if self.entries != nil {
            let index = self.entries?.index(where: {$0 == entry})
            guard let indexVal = index else { return }
            self.entries![indexVal].read = true
            completion()
        }
    }
    
    func dismiss(entry: Entry, completion: @escaping BaseEntryRepository.Completion) {
        if self.entries != nil {
            let index = self.entries?.index(where: {$0 == entry})
            guard let indexVal = index else { return }
            self.entries![indexVal].dismiss = true
            completion()
        }
    }
    
    func dismissAll(completion: @escaping BaseEntryRepository.Completion) {
        self.entries = []
        completion()
    }
    
}
