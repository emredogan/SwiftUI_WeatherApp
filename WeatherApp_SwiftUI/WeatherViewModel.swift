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
    @Published var weatherID: Int = 501
    @Published var date: String = "Today"
    
    @Published var firstDate: String = ""
    @Published var firstTemp: Double = 0.0
    @Published var firstID: Int = 0
    @Published var firstWeatherIcon: String = "😂"

    


    @Published var secondDate: String = ""
    @Published var secondTemp: Double = 0.0
    @Published var secondID: Int = 0
    @Published var secondWeatherIcon: String = "😂"
    
    
    @Published var thirdDate: String = ""
    @Published var thirdTemp: Double = 0.0
    @Published var thirdID: Int = 0
    @Published var thirdWeatherIcon: String = "😂"
    
    @Published var fourthDate: String = ""
    @Published var fourthTemp: Double = 0.0
    @Published var fourthID: Int = 0
    @Published var fourthWeatherIcon: String = "😂"
    
    
    @Published var fifthDate: String = ""
    @Published var fifthTemp: Double = 0.0
    @Published var fifthID: Int = 0
    @Published var fifthWeatherIcon: String = "😂"
    
    public let weatherService: WeatherService
    
    public init(weatherService: WeatherService) {
        self.weatherService = weatherService
    }
    
    
    
    public func refresh() {
        weatherService.loadWeatherData { weather in
            DispatchQueue.main.async {
                self.cityName = weather.city
                self.temperature = "\(weather.temperature)"
                self.weatherDescription = weather.description
                self.weatherID = weather.id
                self.weatherIcon = self.getWeatherIcon(condition: weather.id)
                self.date = self.convertDate(unixTimestamp: weather.date)
                
                self.firstDate = self.convertDate(unixTimestamp: weather.firstDate)
                self.firstTemp = weather.firstTemp
                self.firstID = weather.firstID
                self.firstWeatherIcon = self.getWeatherIcon(condition: self.firstID)


                self.secondDate = self.convertDate(unixTimestamp: weather.secondDate)
                self.secondTemp = weather.secondTemp
                self.secondID = weather.secondID
                self.secondWeatherIcon = self.getWeatherIcon(condition: self.secondID)
                
                
                self.thirdDate = self.convertDate(unixTimestamp: weather.thirdDate)
                self.thirdTemp = weather.thirdTemp
                self.thirdID = weather.thirdID
                self.thirdWeatherIcon = self.getWeatherIcon(condition: self.thirdID)
                
                
                self.fourthDate = self.convertDate(unixTimestamp: weather.fourthDate)
                self.fourthTemp = weather.fourthTemp
                self.fourthID = weather.fourthID
                self.fourthWeatherIcon = self.getWeatherIcon(condition: self.fourthID)
                
                
                self.fifthDate = self.convertDate(unixTimestamp: weather.fifthDate)
                self.fifthTemp = weather.fourthTemp
                self.fifthID = weather.fourthID
                self.fifthWeatherIcon = self.getWeatherIcon(condition: self.fifthID)

            }
        }
    }
    
    public func convertDate(unixTimestamp: Int) -> String {
        let date = Date(timeIntervalSince1970: TimeInterval(unixTimestamp))
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT") //Set timezone that you want
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = "yyyy-MM-dd" //Specify your format that you want
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
            return "cloud.rain.fill"
        }
        
        
    }
    
    
}
