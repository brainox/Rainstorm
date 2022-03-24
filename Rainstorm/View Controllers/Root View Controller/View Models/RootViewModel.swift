//
//  RootViewModel.swift
//  Rainstorm
//
//  Created by Decagon on 23/03/2022.
//

import Foundation

class RootViewModel {
    typealias DidFetchWeatherDataCompletion = ((Data?, Error?) -> Void)
    
    var didFetchWeatherData: DidFetchWeatherDataCompletion?
    
    init() {
        fetchWeatherData()
    }
     
    private func fetchWeatherData() {
    
        // initialize weather request
        let weatherRequest = WeatherRequest(baseUrl: WeatherService.authenticatedBaseURl)
        
        // Create Data Task
        URLSession.shared.dataTask(with:  weatherRequest.url) { [weak self] (data, response, error) in
            if let error = error {
                self?.didFetchWeatherData?(nil, error)
            } else if let data = data {
                self?.didFetchWeatherData?(data, nil)
            } else {
                self?.didFetchWeatherData?(nil, nil)
            }
        }.resume()
    }
}


