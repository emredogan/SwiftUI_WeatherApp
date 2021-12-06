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
    @Published var weatherIcon: String = ""
    @Published var weatherID: Int = 501
    @Published var date: String = "Today"
    
    @Published var weatherList =  [WeatherItem]()

    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    
    
    public func refresh() {
        weatherService.loadCityData { city in
            print("PRINTING - LOAD CITY DATA")
            DispatchQueue.main.async {
                self.cityName = city

            }
        }
        weatherService.loadWeatherData { weather in
            print("PRINTING - LOAD WEATHER DATA")

            DispatchQueue.main.async {
                self.weatherList.removeAll()
                self.date = self.convertDate(unixTimestamp: weather.date)
                //self.cityName = weather.city
                self.temperature = "\(weather.temperature)"
                self.weatherDescription = weather.description
                self.weatherID = weather.id
                self.weatherIcon = self.getWeatherIcon(condition: weather.id)
                self.date = self.convertDate(unixTimestamp: weather.date)
                
                let firstWeatherItem = WeatherItem(date: self.convertDate(unixTimestamp: weather.firstDay.date), temp: weather.firstDay.temp, nightTemp: weather.firstDay.nightTemp, weatherID: weather.firstDay.ID, icon: self.getWeatherIcon(condition: weather.firstDay.ID), description: weather.firstDay.description)
                
                self.weatherList.append(firstWeatherItem)
                
                let secondWeatherItem = WeatherItem(date: self.convertDate(unixTimestamp: weather.secondDay.date), temp: weather.secondDay.temp, nightTemp: weather.secondDay.nightTemp, weatherID: weather.secondDay.ID, icon: self.getWeatherIcon(condition: weather.secondDay.ID), description: weather.secondDay.description)
                
                self.weatherList.append(secondWeatherItem)
                
                let thirdWeatherItem = WeatherItem(date: self.convertDate(unixTimestamp: weather.thirdDay.date), temp: weather.thirdDay.temp, nightTemp: weather.thirdDay.nightTemp, weatherID: weather.thirdDay.ID, icon: self.getWeatherIcon(condition: weather.thirdDay.ID), description: weather.thirdDay.description)
                
                self.weatherList.append(thirdWeatherItem)
                
                let fourthWeatherItem = WeatherItem(date: self.convertDate(unixTimestamp: weather.fourthDay.date), temp: weather.fourthDay.temp, nightTemp: weather.fourthDay.nightTemp, weatherID: weather.fourthDay.ID, icon: self.getWeatherIcon(condition: weather.fourthDay.ID), description: weather.fourthDay.description)
                
                self.weatherList.append(fourthWeatherItem)
                
                let fifthWeatherItem = WeatherItem(date: self.convertDate(unixTimestamp: weather.fifthDay.date), temp: weather.fifthDay.temp, nightTemp: weather.fifthDay.nightTemp, weatherID: weather.fifthDay.ID, icon: self.getWeatherIcon(condition: weather.fifthDay.ID), description: weather.fifthDay.description)
                
                self.weatherList.append(fifthWeatherItem)
                
                let sixthWeatherItem = WeatherItem(date: self.convertDate(unixTimestamp: weather.sixtDay.date), temp: weather.sixtDay.temp, nightTemp: weather.sixtDay.nightTemp, weatherID: weather.sixtDay.ID, icon: self.getWeatherIcon(condition: weather.sixtDay.ID), description: weather.sixtDay.description)
                
                self.weatherList.append(sixthWeatherItem)

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
