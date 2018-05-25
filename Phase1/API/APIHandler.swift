//
//  APIHandler.swift
//  Phase1
//
//  Created by William O'Rosky on 5/24/18.
//  Copyright © 2018 William O'Rosky. All rights reserved.
//

import Foundation
import Alamofire
import PromiseKit

struct APIHandler {
    
    static func getAutofillSuggestion(text:String) -> Promise<[String]> {
        return Promise { seal in
            var requestString = "https://en.wikipedia.org/w/api.php?action=opensearch&format=json&search=" + text
            requestString = requestString.replacingOccurrences(of: " ", with: "%20")
            Alamofire.request(requestString)
                .validate()
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let result):
                        guard let json = result as? [AnyObject] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        guard let suggestions = json[1] as? [String] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        seal.fulfill(suggestions)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }
    
    static func getArticle() -> Promise<[String: Any]> {
        return Promise { seal in
            Alamofire.request("https://jsonplaceholder.typicode.com/users/1")
                .validate()
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let json):
                        guard let json = json  as? [String: Any] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        seal.fulfill(json)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }
    
    static func getPath(_ start:String, end:String) -> Promise<[String: Any]> {
        return Promise { seal in
            let requestString = "http://localhost:5000/api/findscale?start=" + start + "&stop=" + end
            Alamofire.request(requestString)
                .validate()
                .responseJSON { response in
                    
                    switch response.result {
                    case .success(let json):
                        guard let json = json  as? [String: Any] else {
                            return seal.reject(AFError.responseValidationFailed(reason: .dataFileNil))
                        }
                        seal.fulfill(json)
                    case .failure(let error):
                        seal.reject(error)
                    }
            }
        }
    }

}
