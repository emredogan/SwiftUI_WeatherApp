//
//  MainWeatherModel.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 06/01/2022.
//

import Foundation


public struct MainWeather {
    var cityName: String? = "City Name"
    var temperature: String? = "--"
    var weatherDescription: String? = "--"
    var weatherIcon: String? = "cloud.fill"
    var weatherID: Int? = 501
    var date: String? = "Today"
    
    var weatherList =  [WeatherItem]()
    
}
