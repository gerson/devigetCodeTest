//
//  BaseEntryRepository.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import Foundation

protocol BaseEntryRepository {
    typealias Completion = () -> Void
    var count: Int { get }
    var entries: [Entry]? { get set }
    func getAll(_ completion: @escaping Completion)
    func nextPage( identifier: String, completion: @escaping Completion)
    func previousPage( identifier: String, completion: @escaping Completion)
    func markedRead(entry: Entry, completion: @escaping Completion)
    func dismiss(entry: Entry, completion: @escaping Completion)
    func dismissAll(completion: @escaping BaseEntryRepository.Completion)
}
