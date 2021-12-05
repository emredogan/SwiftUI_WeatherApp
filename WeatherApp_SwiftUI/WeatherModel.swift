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
    let firstNightTemp: Double
    let firstID: Int
    let firstDescription: String
    
    
    let secondDate: Int
    let secondTemp: Double
    let secondNightTemp: Double
    let secondID: Int
    let secondDescription: String

    
    let thirdDate: Int
    let thirdTemp: Double
    let thirdNightTemp: Double
    let thirdID: Int
    let thirdDescription: String

    
    let fourthDate: Int
    let fourthTemp: Double
    let fourthNightTemp: Double
    let fourthID: Int
    let fourthDescription: String

    
    
    let fifthDate: Int
    let fifthTemp: Double
    let fifthNightTemp: Double
    let fifthID: Int
    let fifthDescription: String

    
    let sixthDate: Int
    let sixthTemp: Double
    let sixthNightTemp: Double
    let sixthID: Int
    let sixthDescription: String

    
    init(response: APIResponse) {
        city = response.timezone
        temperature = "\(Int(response.current.temp))"
        description = response.current.weather[0].description.capitalized
        id = response.current.weather[0].id
        date = response.current.dt
        
        firstDate = response.daily[0].dt
        firstTemp = response.daily[0].temp["day"] ?? 0.0
        firstNightTemp = response.daily[0].temp["night"] ?? 0.0
        firstID = response.daily[0].weather[0].id
        firstDescription = response.daily[0].weather[0].description.capitalized



        
        secondDate = response.daily[1].dt
        secondTemp = response.daily[1].temp["day"] ?? 0.0
        secondNightTemp = response.daily[1].temp["night"] ?? 0.0
        secondID = response.daily[1].weather[0].id
        secondDescription = response.daily[1].weather[0].description.capitalized

        
        thirdDate = response.daily[2].dt
        thirdTemp = response.daily[2].temp["day"] ?? 0.0
        thirdNightTemp = response.daily[2].temp["night"] ?? 0.0
        thirdID = response.daily[2].weather[0].id
        thirdDescription = response.daily[2].weather[0].description.capitalized

        
        
        fourthDate = response.daily[3].dt
        fourthTemp = response.daily[3].temp["day"] ?? 0.0
        fourthNightTemp = response.daily[3].temp["night"] ?? 0.0
        fourthID = response.daily[3].weather[0].id
        fourthDescription = response.daily[3].weather[0].description.capitalized

        
        fifthDate = response.daily[4].dt
        fifthTemp = response.daily[4].temp["day"] ?? 0.0
        fifthNightTemp = response.daily[4].temp["night"] ?? 0.0
        fifthID = response.daily[4].weather[0].id
        fifthDescription = response.daily[4].weather[0].description.capitalized

        
        sixthDate = response.daily[5].dt
        sixthTemp = response.daily[5].temp["day"] ?? 0.0
        sixthNightTemp = response.daily[0].temp["night"] ?? 0.0
        sixthID = response.daily[5].weather[0].id
        sixthDescription = response.daily[5].weather[0].description.capitalized


    }
}
