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
    /*
    let description: String
    let iconName: String */
    
    init(response: APIResponse) {
        city = response.name
        temperature = "\(Int(response.main.temp))"
        print("TEMP IS \(temperature)")
        /*
        description = response.weather.description
        iconName = response.weather.iconName */
    }
}
