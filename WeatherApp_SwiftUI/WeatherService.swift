//
//  WeatherService.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 29/11/2021.
//

import Foundation
import CoreLocation
import SwiftUI

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private let API_KEY = "9d8b950fe81cd20073b4791eea6cf783"
    private var completionHandler: ((Weather)-> Void)?
    
    public override init() {
        super.init()
        locationManager.delegate = self
    }
    public func loadWeatherData(_ completionHandler:@escaping ((Weather)-> Void)) { // Escaping is usually used in network calls. Closure is ESCAPING the lifetime of this function. When you make a network call, it takes time. So it needs to outlive the function lifetime and wait. It lives in the memory.
        print("Starting load weather data")

        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    private func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        print("Starting the data request")
        // Guard makes sure the urlString has a value. If not just return.
        guard let urlString =  "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return} // addingPercentEncoding: Returns a new string by replacing all chars not in the urlQueryAllowed set of chars
        
        print("Trying the network request with the following link \(urlString)")
        
        guard let url = URL(string: urlString) else {
            print("Can't parse the url")

            return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                print("Error or data is nill")
                return} // Make sure that the error is nil and the data exists
            

              do {
                  let weatherObject = try JSONDecoder().decode(APIResponse.self, from: data)

                print("decoded response is \(weatherObject)")
                  self.completionHandler?(Weather(response: weatherObject))
                  
              } catch let jsonError as NSError {
                print("JSON decode failed: \(jsonError.localizedDescription)")
                  print("JSON decode failed: \(jsonError)")
              }
              return
            
        }.resume()
        
    }
    

}

extension WeatherService: CLLocationManagerDelegate {
    public func locationManager (
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]) {
            guard let location = locations.first else {return}
            makeDataRequest(forCoordinates: location.coordinate)
        }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription) ")
    }
    
}

struct APIResponse: Decodable {
    let name: String
    let main: APIMain
    let weather: [APIWeather]
}

struct APIMain: Decodable {
    let temp: Double
}
struct APIWeather: Decodable { // Decodable: We want to convert(decode) the JSON type to our own custom type
    let description: String
    //let iconName: String
    
    /*enum CodingKeys: String, CodingKey {
        case description
        case iconName = "main"
    } */
    
}
