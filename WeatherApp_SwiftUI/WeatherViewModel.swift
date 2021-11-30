//
//  WeatherViewModel.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 29/11/2021.
//

import Foundation

public class WeatherViewModel: ObservableObject { // Should be observed by the view
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = "😂"
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                print("LOAD TEMP IS \(weather.temperature)")
                self.temperature = "\(weather.temperature)"
                self.weatherDescription = weather.description
                //self.weatherIcon
            }
        }
    }
}
