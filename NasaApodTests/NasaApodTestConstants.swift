//
//  NasaApodTestConstants.swift
//  NasaApodTests
//
//  Created by Nishant Bhasin on 7/31/18.
//  Copyright © 2018 Nishant Bhasin. All rights reserved.
//

import Foundation

struct testResponseContract {
    static let perfect = """
        {
        "date": "2018-07-31",
        "explanation": "What lies beneath the layered south pole of Mars? A recent measurement with ground-penetrating radar from ESA's Mars Express satellite has detected a bright reflection layer consistent with an underground lake of salty water. The reflection comes from about 1.5-km down but covers an area 200-km across. Liquid water evaporates quickly from the surface of Mars, but a briny confined lake, such as implied by the radar reflection, could last much longer and be a candidate to host life such as microbes.  Pictured, an infrared, green, and blue image of the south pole of Mars taken by Mars Express in 2012 shows a complex mixture of layers of dirt, frozen carbon dioxide, and frozen water.",
        "hdurl": "https://apod.nasa.gov/apod/image/1807/SouthPole_MarsExpress_2310.jpg",
        "media_type": "image",
        "service_version": "v1",
        "title": "Layers of the South Pole of Mars",
        "url": "https://apod.nasa.gov/apod/image/1807/SouthPole_MarsExpress_1080.jpg"
        }
        """
    
    static let wrongIntUrl = """
        {
        "date": "2018-07-31",
        "explanation": "",
        "hdurl":1,
        "media_type": "image",
        "service_version": "v1",
        "title": "Layers of the South Pole of Mars",
        "url": "https://apod.nasa.gov/apod/image/1807/SouthPole_MarsExpress_1080.jpg"
        }
        """
    
    static let emptyJsonResponse = """
        {

        }
        """
    static let emptyString = ""
}
