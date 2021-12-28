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
        var keys: NSDictionary?
        
        // API KEYS saved in the plist file.
        if let path = Bundle.main.path(forResource: "GooglePlace-Info", ofType: "plist") {
               keys = NSDictionary(contentsOfFile: path)
           }
            if let dict = keys {
                let googleAPIKEY = (dict["API_KEY"] as? String)!
            
                // Initialize GooglePlaces.
                GMSPlacesClient.provideAPIKey(googleAPIKEY)

            }
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            let weatherService = WeatherService()
            let viewModel = WeatherViewModel(weatherService: weatherService)
            WeatherView(viewModel: viewModel)
        }
    }
    
    
}
