//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Decagon on 23/03/2022.
//

import Foundation

class RootViewModel {
    enum WeatherDataError: Error {
        case noWeatherDataAvailable
    }
    
    typealias DidFetchWeatherDataCompletion = ((OpenWeatherResponse?, WeatherDataError?) -> Void)
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    init() {
        fetchWeatherData()
    }
     
    private func fetchWeatherData() {
    
        // initialize weather request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseURl)
        
        // Create Data Task
        URLSession.shared.dataTask(with:  weatherRequest.url) { [weak self] (data, response, error) in
            if let response = response as? HTTPURLResponse {
                print(response.statusCode)
            }
            if let error = error {
                print("Unable to fetch weather data \(error)")
                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
            } else if let data = data {
                let decoder = JSONDecoder()
                
                do {
                    let openWeatherResponse = try decoder.decode(OpenWeatherResponse.self, from: data)
                    self?.didFetchWeatherData?(openWeatherResponse, nil)
                } catch {
                    print("Unable to decode response with \(error)")
                    self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
                }
            } else {
                self?.didFetchWeatherData?(nil, .noWeatherDataAvailable)
            }
        }.resume()
    }
}


