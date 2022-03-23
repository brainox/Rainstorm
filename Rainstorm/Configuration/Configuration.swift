//
//  Configuration.swift
//  Rainstorm
//
//  Created by Decagon on 23/03/2022.
//

import Foundation

enum Defaults {
    static let latitude: Double = 9.0
    static let apiKey = "96c1d443fdd0fbe9d24370ca1c886d26"
}
enum WeatherService {
    static let authenticatedBaseURl = URL(string: "https://api.openweathermap.org/data/2.5/onecall?lat=\(Defaults.latitude)&exclude=minutely,alerts,hourly&lon=1.2&appid=\(Defaults.apiKey)")!
}
