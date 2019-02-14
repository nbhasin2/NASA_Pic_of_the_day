//
//  NetworkManager.swift
//  NasaApod
//
//  Created by Nishant Bhasin on 7/30/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import Foundation
import UIKit

class NetworkManager: NSObject {
    static let shared = NetworkManager()
    
    ///Network Manager getApodData is used to get initial data from APOD api
    ///It takes in ApodResponseData and Error completion block to return those elements
    ///Error we need for when anything could go wrong while fetching data.
    ///ApodResponseData makes it easy to get the url from the response
    func getApodData(from url: URL, completion: @escaping (ApodResponseData?,Error?) -> Void) {
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        var headers = request.allHTTPHeaderFields ?? [:]
        headers["Content-Type"] = "application/json"
        request.allHTTPHeaderFields = headers
        let config = URLSessionConfiguration.default
        config.timeoutIntervalForRequest = ApodApiConstants.timeoutIntervalForRequest
        config.timeoutIntervalForResource = ApodApiConstants.timeoutIntervalForResource
        let session = URLSession(configuration: config)
        let task = session.dataTask(with: request){ data, response, error in
            guard error == nil else {
                completion(nil,NSError(domain:"No Internet", code:ApodErrorCodes.GenericError.rawValue, userInfo:nil))
                return
            }
        
            if let httpResponse = response as? HTTPURLResponse {
                let httpErr = NSError(domain:"", code:httpResponse.statusCode, userInfo:nil)
                //We check for 200 and 202 i.e. Ok or Accepted response.
                //If we get anything other than that we return with an error
                //that contains the http reponse code in completion block
                if !(self.isHttpResponseOkAccepted(with: httpResponse)) {
                    completion(nil,httpErr)
                    return
                }
            }
            
            if let responseData = data, let utf8Representation = String(data: responseData, encoding: .utf8) {
                print("response: ", utf8Representation)
                let apodData = ApodResponseData.parse(json: utf8Representation)
                completion(apodData,error)
            } else {
                completion(nil,error)
                print("no readable data received in response")
            }

        }
        task.resume()
    }
    
    ///Helper method to download just the image that takes in a closure so we can get Data back
    func downloadImage(url: URL, completion: @escaping (Data?,Error?) -> Void){
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return }
            completion(data,error)
            }.resume()
    }
}

//Helper methods
extension NetworkManager {
    
    func isHttpResponseOkAccepted(with reponse:HTTPURLResponse) -> Bool {
        if (reponse.statusCode == ApodApiConstants.ResponseCode.ok ||
            reponse.statusCode == ApodApiConstants.ResponseCode.accepted) {
            return true
        }
        return false
    }
    
}

