//
//  EntryViewModel.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import Foundation

class EntryViewModel {
    
    var entryRepo: BaseEntryRepository
    var count: Int {  if let entries = self.entryRepo.entries {
        return entries.filter({ $0.dismiss == false || $0.dismiss == nil }).count
    } else {
        return 0
        } }
    
    var entries: [Entry]? { return self.entryRepo.entries?.filter { $0.dismiss == false  || $0.dismiss == nil} }
    
    init(entryRepo: BaseEntryRepository) {
        self.entryRepo = entryRepo
    }
    
    func getAllEntries(completion: @escaping () -> Void) {
        self.entryRepo.getAll {
            completion()
        }
    }
    
    func dismissAll(completion: @escaping () -> Void) {
        self.entryRepo.dismissAll {
            completion()
        }
    }
    
    func markedRead(_ entry: Entry, completion: @escaping () -> Void) {
        self.entryRepo.markedRead(entry: entry) {
            completion()
        }
    }
    
    func dismissEntry(_ entry: Entry, completion: @escaping () -> Void) {
        self.entryRepo.dismiss(entry: entry) {
            completion()
        }
    }
    
}
