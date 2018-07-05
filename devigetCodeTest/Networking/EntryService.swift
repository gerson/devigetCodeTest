//
//  EntryService.swift
//  devigetCodeTest
//
//  Created by Gerson Villanueva on 05/07/2018.
//  Copyright © 2018 Gerson Villanueva. All rights reserved.
//

import Foundation

class EntryService {
    
    typealias EntriesResponse = ([Entry]?, String?) -> ()
    let defaultSession = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var errorMessage: String = ""
    let baseURLString = Bundle.main.object(forInfoDictionaryKey: "BaseURLKey") as? String
    
    func getTopEntries(after: String?, before: String?, completion: @escaping EntriesResponse) {
        dataTask?.cancel()
        if var urlComponents = URLComponents(string: baseURLString!) {
            if let after = after {
                urlComponents.query = "after=\(after)"
            }
            if let before = before {
                urlComponents.query = "before=\(before)"
            }
            
            guard let url = urlComponents.url else { return }
            
            dataTask = defaultSession.dataTask(with: url, completionHandler: { data, response, error in
                defer { self.dataTask = nil }
                if let error = error {
                    self.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                } else if let data = data,
                    let response = response as? HTTPURLResponse,
                    response.statusCode == 200 {
                    var entries: [Entry]?
                    do {
                        let decoder = JSONDecoder()
                        decoder.dateDecodingStrategy = .secondsSince1970
                        let entryList = try decoder.decode(TopEntriesResponse.self, from: data)
                        entries = entryList.data.children.map { $0.data }
                    } catch  {
                        print("Error parsing response: \(error.localizedDescription)")
                        return
                    }
                    DispatchQueue.main.async {
                        completion(entries, self.errorMessage)
                    }
                }
            })
            dataTask?.resume()
        }
    }
}
