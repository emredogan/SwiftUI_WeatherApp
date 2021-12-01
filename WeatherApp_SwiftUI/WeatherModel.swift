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
    
    let firstDate: Int
    let firstTemp: Double
    let firstID: Int
    
    
    let secondDate: Int
    let secondTemp: Double
    let secondID: Int
    
    let thirdDate: Int
    let thirdTemp: Double
    let thirdID: Int
    
    let fourthDate: Int
    let fourthTemp: Double
    let fourthID: Int
    
    
    let fifthDate: Int
    let fifthTemp: Double
    let fifthID: Int
    
    init(response: APIResponse) {
        city = response.timezone
        temperature = "\(Int(response.current.temp))"
        description = response.current.weather[0].description.capitalized
        id = response.current.weather[0].id
        date = response.current.dt
        
        firstDate = response.daily[0].dt
        firstTemp = response.daily[0].temp["day"] ?? 0.0
        firstID = response.daily[0].weather[0].id


        
        secondDate = response.daily[1].dt
        secondTemp = response.daily[1].temp["day"] ?? 0.0
        secondID = response.daily[1].weather[0].id
        
        thirdDate = response.daily[2].dt
        thirdTemp = response.daily[2].temp["day"] ?? 0.0
        thirdID = response.daily[2].weather[0].id
        
        
        fourthDate = response.daily[3].dt
        fourthTemp = response.daily[3].temp["day"] ?? 0.0
        fourthID = response.daily[3].weather[0].id
        
        fifthDate = response.daily[4].dt
        fifthTemp = response.daily[4].temp["day"] ?? 0.0
        fifthID = response.daily[4].weather[0].id

    }
}
