//
//  Decodable+Extenstion.swift
//  Rider
//
//  Created by Mac mini on 8/23/18.
//  Copyright © 2018 Mac mini. All rights reserved.
//

import Foundation
typealias JSON = [String: Any]
typealias JSONArray = [JSON]


func parseJSONIntoModel<T: Decodable>(json: JSONArray) -> [T]? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json,
                                                      options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonDecoder = JSONDecoder()
            let modelArray = try jsonDecoder.decode([T].self, from: jsonData)
            return modelArray
        } catch let error {
            print(error)
        }
        return nil
    }
    
    func decode<T: Decodable>(json: JSON) -> T? {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: json,
                                                      options: JSONSerialization.WritingOptions.prettyPrinted)
            let jsonDecoder = JSONDecoder()
            let model = try jsonDecoder.decode(T.self, from: jsonData)
            return model
        } catch {
            print(error)
        }
        return nil
    }
    
