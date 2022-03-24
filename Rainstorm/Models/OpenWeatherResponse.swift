//
//  WeatherResponse.swift
//  Rainstorm
//
//  Created by Decagon on 24/03/2022.
//

import Foundation

// MARK: - OpenWeatherResponse
struct OpenWeatherResponse: Codable {
    let lat: Int
    let lon: Double
    let current: Current
    let daily: [Daily]

    enum CodingKeys: String, CodingKey {
        case lat, lon
        case current, daily
    }
}

// MARK: - Current
struct Current: Codable {
    let time: Date
    let temp : Double
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case temp
        case time = "dt"
        case windSpeed = "wind_speed"
        case weather
    }
}

// MARK: - Weather
struct Weather: Codable {
    let id: Int
    let main, weatherDescription, icon: String

    enum CodingKeys: String, CodingKey {
        case id, main
        case weatherDescription = "description"
        case icon
    }
}

// MARK: - Daily
struct Daily: Codable {
    let dt : Int
    let temp: Temp
    let windSpeed: Double
    let weather: [Weather]

    enum CodingKeys: String, CodingKey {
        case dt
        case temp
        case windSpeed = "wind_speed"
        case weather
    }
}


// MARK: - Temp
struct Temp: Codable {
    let min, max : Double
}

