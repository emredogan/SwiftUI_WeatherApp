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
    
    let firstDay: DailyWeatherModel
    let secondDay: DailyWeatherModel
    let thirdDay: DailyWeatherModel
    let fourthDay: DailyWeatherModel
    let fifthDay: DailyWeatherModel
    let sixtDay: DailyWeatherModel


    
    init(response: APIResponse) {
        city = response.timezone
        temperature = "\(Int(response.current.temp))"
        description = response.current.weather[0].description.capitalized
        id = response.current.weather[0].id
        date = response.current.dt
        
        firstDay = DailyWeatherModel(date: response.daily[0].dt, temp: response.daily[0].temp["day"] ?? 0.0, nightTemp: response.daily[0].temp["night"] ?? 0.0, ID: response.daily[0].weather[0].id, description: response.daily[0].weather[0].description.capitalized)
        
        secondDay = DailyWeatherModel(date: response.daily[1].dt, temp: response.daily[1].temp["day"] ?? 0.0, nightTemp: response.daily[1].temp["night"] ?? 0.0, ID: response.daily[1].weather[0].id, description: response.daily[1].weather[0].description.capitalized)
        
        thirdDay = DailyWeatherModel(date: response.daily[2].dt, temp: response.daily[2].temp["day"] ?? 0.0, nightTemp: response.daily[2].temp["night"] ?? 0.0, ID: response.daily[2].weather[0].id, description: response.daily[2].weather[0].description.capitalized)
        
        fourthDay = DailyWeatherModel(date: response.daily[3].dt, temp: response.daily[3].temp["day"] ?? 0.0, nightTemp: response.daily[3].temp["night"] ?? 0.0, ID: response.daily[3].weather[0].id, description: response.daily[3].weather[0].description.capitalized)
        
        fifthDay = DailyWeatherModel(date: response.daily[4].dt, temp: response.daily[4].temp["day"] ?? 0.0, nightTemp: response.daily[4].temp["night"] ?? 0.0, ID: response.daily[4].weather[0].id, description: response.daily[4].weather[0].description.capitalized)
        
        sixtDay = DailyWeatherModel(date: response.daily[5].dt, temp: response.daily[5].temp["day"] ?? 0.0, nightTemp: response.daily[0].temp["night"] ?? 0.0, ID: response.daily[5].weather[0].id, description: response.daily[5].weather[0].description.capitalized)

    }
}


