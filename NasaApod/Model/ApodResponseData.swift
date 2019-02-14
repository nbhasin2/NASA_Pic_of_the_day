//
//  NasaApodData.swift
//  NasaApod
//
//  Created by Nishant Bhasin on 7/30/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import Foundation
import UIKit

///Using ApodResponseData codable to store the response data we get from the server
///Codables are great way to easily parse the JSON as it is a part of Decodable / Codable protocol
struct ApodResponseData: Codable {
    let date, explanation, hdurl, mediaType: String?
    let serviceVersion, title, url: String?
    
    enum CodingKeys: String, CodingKey {
        case date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

extension ApodResponseData {
    ///Handy method to parse the JSON via input string and get object representation
    ///of the response data
    static func parse(json input:String) -> ApodResponseData? {
        let data: Data = input.data(using: .utf8)!
        let decoder = JSONDecoder()
        
        do {
            let apodData = try decoder.decode(ApodResponseData.self, from: data)
            return apodData
        } catch {
            return nil
        }
    }
}
