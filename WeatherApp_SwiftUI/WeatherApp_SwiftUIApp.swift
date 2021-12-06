//
//  WeatherApp_SwiftUIApp.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 25/11/2021.
//

import SwiftUI
import GooglePlaces

@main
struct WeatherApp_SwiftUIApp: App {
    
    init() {
        GMSPlacesClient.provideAPIKey("AIzaSyAxap_9cAlrmPpzZHL274R4b3bWrEbdQmw")
    }
    
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            WeatherView(viewModel: viewModel)
        }
    }
    
    
}
