//
//  Constants.swift
//  NasaApod
//
//  Created by Nishant Bhasin on 7/30/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//
import UIKit

//General App Constants

struct ApodUrlConstants {
    static let key =  "DEMO_KEY"//"{Nasa-Api-Key-Goes-Here}"
    static let host = "api.nasa.gov"
    static let path = "/planetary/apod"
}

struct ApodStringConstants {
    static let genericError = NSLocalizedString("Error: Unable to load the data.\nPlease try again.", comment: "Generic Error")
}

struct ApodUIConstants {
    static let transitionDuration = 0.35
}

struct ApodApiConstants {
    static let timeoutIntervalForRequest = 10.0 //Sec
    static let timeoutIntervalForResource = 60.0 //Sec
    
    struct ResponseCode {
        static let ok = 200
        static let accepted = 202
    }
}

enum ApodErrorCodes:Int {
    case GenericError = 1
}
