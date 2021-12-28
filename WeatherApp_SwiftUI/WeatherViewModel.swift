//
//  WeatherViewModel.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 29/11/2021.
//

import Foundation
import SwiftUI

public class WeatherViewModel: ObservableObject { // Should be observed by the view
    @Published var cityName: String = "City Name"
    @Published var temperature: String = "--"
    @Published var weatherDescription: String = "--"
    @Published var weatherIcon: String = "cloud.fill"
    @Published var weatherID: Int = 501
    @Published var date: String = "Today"
    
    @Published var weatherList =  [WeatherItem]()

    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    
    
    public func refresh() {
        weatherService.loadCityData { city in
            DispatchQueue.main.async {
                self.cityName = city

            }
        }
        weatherService.loadWeatherData { result in
            switch result {
            case .success(let weather):
                DispatchQueue.main.async {
                    self.weatherList.removeAll()
                    self.date = self.convertDate(unixTimestamp: weather.date)
                    self.temperature = "\(weather.temperature)"
                    self.weatherDescription = weather.description
                    self.weatherID = weather.id
                    self.weatherIcon = self.getWeatherIcon(condition: weather.id)
                    self.date = self.convertDate(unixTimestamp: weather.date)
                    
                    for i in 0...5 {
                        let weatherItem = WeatherItem(date: self.convertDate(unixTimestamp: weather.days[i].date), temp: weather.days[i].temp, nightTemp: weather.days[i].nightTemp, weatherID: weather.days[i].ID, icon: self.getWeatherIcon(condition: weather.days[i].ID), description: weather.days[i].description)
                        
                        self.weatherList.append(weatherItem)

                    }

                }
                
            case .failure(let error):
                print(error)
                
            }
        }
        
    }
    
    public func convertDate(unixTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "EEE,MMMM d" //Specify your format that you want
        let strDate = dateFormatter.string(from: date)
        return strDate
    }
    
    public func getWeatherIcon(condition: Int) -> String {
        switch condition {
        case 200..<400:
        return "cloud.bolt.fill" // Thunderstorm
        case 500..<600:
            return "cloud.rain.fill" // Rain
        case 600..<700:
            return "cloud.snow.fill" // Snow
        case 700..<800:
            return "cloud.fog.fill" // Mist
        case 800: // Clear
            return "sun.max.fill" // Clear
        case 801..<805:
            return "cloud.fill" // Clouds
        
        default:
            return "cloud.fill"
        }
        
        
    }
    
    
}

struct WeatherItem: Identifiable {
    var id = UUID()
    var date: String = ""
    var temp: Double = 0.0
    var nightTemp: Double = 0.0
    var weatherID: Int = 0
    var icon: String = "😂"
    var description: String = ""
    
    init(date: String, temp: Double, nightTemp: Double, weatherID: Int, icon: String, description: String) {
        self.date = date
        self.temp = temp
        self.nightTemp = nightTemp
        self.weatherID = weatherID
        self.icon = icon
        self.description = description
    }
}
