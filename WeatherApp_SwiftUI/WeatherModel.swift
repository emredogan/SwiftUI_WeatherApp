//
//  WeatherModel.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 29/11/2021.
//

import Foundation

public struct Weather {
    let city: String
    let temperature: String
    let description: String
    let id: Int
    let date: Int
    
    var days = [DailyWeatherModel]()

    
    init(response: APIResponse) {
        city = response.timezone
        temperature = "\(Int(response.current.temp))"
        description = response.current.weather[0].description.capitalized
        id = response.current.weather[0].id
        date = response.current.dt
        
        
        for i in 0...5 {
            let day = DailyWeatherModel(date: response.daily[i].dt, temp: response.daily[i].temp["day"] ?? 0.0, nightTemp: response.daily[i].temp["night"] ?? 0.0, ID: response.daily[i].weather[0].id, description: response.daily[i].weather[0].description.capitalized)
            days.append(day)
        }
        
    }
}


