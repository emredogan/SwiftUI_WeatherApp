//
//  WeatherService.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 29/11/2021.
//

import Foundation
import CoreLocation
import SwiftUI
import UIKit
import MapKit

public final class WeatherService: NSObject {
    private let locationManager = CLLocationManager()
    private var API_KEY_WEATHER = ""
    private var completionHandler: ((Result<Weather, MyCustomError>)-> Void)?
    
    private var cityNameCompletionHandler: ((String)-> Void)?
    var location = CLLocation(latitude: -22.963451, longitude: -43.198242)
    
    public override init() {
        super.init()
        var keys: NSDictionary?
        
        // API KEYS saved in the plist file.
        if let path = Bundle.main.path(forResource: "GooglePlace-Info", ofType: "plist") {
               keys = NSDictionary(contentsOfFile: path)
           }
            if let dict = keys {
                API_KEY_WEATHER = (dict["API_KEY_WEATHER"] as? String)!


            }
        locationManager.delegate = self
    }
    
    public func loadCityData(_ completionHandler:@escaping ((String)-> Void)) {
        
        print("PRINTING LOAD CITY STARTS")

        
        self.cityNameCompletionHandler = completionHandler
        locationManager.distanceFilter = 100.0; // Will notify the LocationManager every 100 meters
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    public func makeCityDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        
        location.fetchCityAndCountry {adminArea, city, country, error in
            guard let city = city, let country = country, let adminArea = adminArea, error == nil else { return }
            print("PRINTING CITY")
            print(city + ", " + country)  // Rio de Janeiro, Brazil
            self.cityNameCompletionHandler!("\(city), \(adminArea), \(country)")
        }

        
    }
    
    func loadWeatherData(_ completionHandler:@escaping ((Result<Weather, MyCustomError>)-> Void)) { // Escaping is usually used in network calls. Closure is ESCAPING the lifetime of this function. When you make a network call, it takes time. So it needs to outlive the function lifetime and wait. It lives in the memory.
        print("Starting load weather data")
        self.completionHandler = completionHandler
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    public func makeDataRequest(forCoordinates coordinates: CLLocationCoordinate2D) {
        print("Starting the data request")
        print("Starting the city request")
        location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
        

        // Guard makes sure the urlString has a value. If not just return.
       /*  guard let urlString =  "https://api.openweathermap.org/data/2.5/weather?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&appid=\(API_KEY)&units=metric"
                .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return} // addingPercentEncoding: Returns a new string by replacing all chars not in the urlQueryAllowed set of chars */
        
        guard let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=\(coordinates.latitude)&lon=\(coordinates.longitude)&exclude=hourly,minutely&appid=\(API_KEY_WEATHER)&units=metric"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        else {
            completionHandler!(.failure(.JSONERROR))
            return
        }
        
        print("Trying the network request with the following link \(urlString)")
        
        guard let url = URL(string: urlString) else {
            completionHandler!(.failure(.JSONERROR))
            print("Can't parse the url")

            return}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil, let data = data else {
                print("Error or data is nill")
                self.completionHandler!(.failure(.JSONERROR))
                return} // Make sure that the error is nil and the data exists
            

              do {
                  let weatherObject = try JSONDecoder().decode(APIResponse.self, from: data)

                print("decoded response is \(weatherObject)")
                  self.completionHandler!(.success(Weather(response: weatherObject)))
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
            print("CHANGEDD2",      locationManager.location?.coordinate)

            guard let location = locations.first else {return}
            makeDataRequest(forCoordinates: location.coordinate)
            makeCityDataRequest(forCoordinates: location.coordinate)
        }
    
    public func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Something went wrong: \(error.localizedDescription) ")
    }
    
    public func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        locationManager.startUpdatingLocation()
        print("CHANGEDD1",      locationManager.location?.coordinate)
        if (locationManager.authorizationStatus == CLAuthorizationStatus.denied) {
            // The user denied authorization
            print("REJECTED PERMISSION")
        } else if (locationManager.authorizationStatus == CLAuthorizationStatus.authorizedAlways) {
            // The user accepted authorization
            print("ACCEPTED PERMISSION")

        } else if (locationManager.authorizationStatus == CLAuthorizationStatus.authorizedWhenInUse) {
            print("ACCEPTED PERMISSION2")
        }
    }

}

struct APIResponse: Decodable {
    let timezone: String
    let current: APICurrent
    let daily: [APIDaily]
}

struct APICurrent: Decodable {
    let temp: Double
    let dt: Int
    let weather: [APIWeather]
}
struct APIWeather: Decodable { // Decodable: We want to convert(decode) the JSON type to our own custom type
    let description: String
    let id:Int
}

struct APIDaily: Decodable {
    let dt: Int
    let temp: [String:Double]
    let weather: [APIWeather]
}

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ administrativeArea: String?,_ locality: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.administrativeArea, $0?.first?.locality, $0?.first?.country, $1) }
    }
}
