//
//  ContentView.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 25/11/2021.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    @State private var isNight = true
    var body: some View {
        ZStack {
            BackgroundView(isNight: $isNight)
            VStack(spacing: 8) {
                CityTextView(cityName: viewModel.cityName)
                MainWeatherStatusView(imageName: isNight ? viewModel.weatherIcon : viewModel.weatherIcon, temp: viewModel.temperature, description: viewModel.weatherDescription)
                
                                
                VStack(spacing: 16) {
                    WeatherDayView(dayOfWeek:viewModel.firstDate , imageName: viewModel.firstWeatherIcon, temp: Int(viewModel.firstTemp))
                    WeatherDayView(dayOfWeek: viewModel.secondDate, imageName: viewModel.secondWeatherIcon, temp: Int(viewModel.secondTemp))
                    WeatherDayView(dayOfWeek: viewModel.thirdDate, imageName: viewModel.thirdWeatherIcon, temp: Int(viewModel.thirdTemp))
                    WeatherDayView(dayOfWeek: viewModel.fourthDate, imageName: viewModel.fourthWeatherIcon, temp: Int(viewModel.fourthTemp))
                    WeatherDayView(dayOfWeek: viewModel.fifthDate, imageName: viewModel.fifthWeatherIcon, temp: Int(viewModel.fifthTemp))

                }
                Spacer()
                
                Button {
                    isNight.toggle()
                    
                } label : {
                    WeatherButton(title: "Change Day Time", textColor: .blue, backgroundColor: .white)
                }
                
                Spacer()
                   
            }
            
        }.onAppear(perform: viewModel.refresh)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String
    var imageName: String
    var temp: Int
    
    var body: some View {
        HStack {
            Text(dayOfWeek)
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 30, height: 30)
            Text("\(temp)")
                .font(.system(size: 16, weight: .medium, design: .default))
                .foregroundColor(.white)
        }
    }
}

struct BackgroundView: View {
    
    @Binding var isNight:Bool
    
    var body: some View {
        LinearGradient(gradient:Gradient(colors:  [isNight ? .black : .blue, isNight ? .gray : .white]),
                       startPoint: .topLeading,
                       endPoint: .bottomTrailing)
            .ignoresSafeArea()
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        Text(cityName)
            .font(.system(size: 32, weight: .medium, design: .default))
            .foregroundColor(.white)
            .padding()
    }
}

struct MainWeatherStatusView: View {
    var imageName: String
    var temp: String
    var description: String
    var body: some View {
        VStack(spacing: 8) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 180, height: 180)
            
            Text(description)
                .font(.system(size: 35, weight: .medium, design: .default))
                .foregroundColor(.white)
            
            Text("\(temp) ˚C")
                .font(.system(size: 70, weight: .medium, design: .default))
                .foregroundColor(.white)
                
        }
    }
}

