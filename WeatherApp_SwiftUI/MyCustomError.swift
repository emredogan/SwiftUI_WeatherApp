//
//  MyCustomError.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 28/12/2021.
//

import Foundation

enum MyCustomError : String, Error {
    case JSONERROR = "JSONERROR"
    case OTHERERROR = "OTHERERROR"

}
