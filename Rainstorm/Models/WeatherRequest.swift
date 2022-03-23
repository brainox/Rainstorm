//
//  WeatherRequest.swift
//  Rainstorm
//
//  Created by Decagon on 23/03/2022.
//

import Foundation

struct WeatherRequest {
    let baseUrl: URL
    
    var url: URL {
        return baseUrl
    }
}
