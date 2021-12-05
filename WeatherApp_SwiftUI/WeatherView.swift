//
//  ContentView.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 25/11/2021.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    
    var body: some View {
        ZStack {
            
            VStack (spacing: 0){
                HStack {
                    MainWeatherStatusView(imageName:  viewModel.weatherIcon, temp: viewModel.temperature, date: viewModel.date , description: viewModel.weatherDescription, cityName:  viewModel.cityName)
                }
                .frame(width: .infinity, height: 250, alignment: .center)
                .background(.orange)
                
                
                List(viewModel.weatherList, id: \.id) { item in
                    WeatherDayView(dayOfWeek:item.date , imageName: item.icon, temp: Int(item.temp), nightTemp: Int(item.nightTemp), description: item.description)
                    
                }
                .listStyle(PlainListStyle())
                
            }.frame(alignment: .topTrailing)
            
        }.onAppear(perform: viewModel.refresh)
        
        
        
    }
    
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(viewModel: WeatherViewModel(weatherService: WeatherService()))
    }
}

struct WeatherDayView: View {
    var dayOfWeek: String = "Thursday"
    var imageName: String = "sun.max.fill"
    var temp: Int = 25
    var nightTemp: Int = 0
    var description: String
    
    var body: some View {
        
        HStack(alignment: .top) {
            Image(systemName: imageName)
                .renderingMode(.original)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 60, height: 60)
            
            HStack {
                VStack(alignment: .leading, spacing: 10) {
                    Text(dayOfWeek)
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Text(description)
                        .font(.system(size: 16, weight: .light, design: .default))
                        .foregroundColor(.black)
                }
                
                Spacer()
                
                VStack(spacing: 10) {
                    Text("\(temp)˚C")
                        .font(.system(size: 16, weight: .bold, design: .default))
                        .foregroundColor(.black)
                    Text("\(nightTemp)˚C")
                        .font(.system(size: 16, weight: .light, design: .default))
                        .foregroundColor(.black)
                }
            }
        }
        .listRowBackground(Color(red: 201 / 255, green: 217 / 255, blue: 181 / 255))
        .frame(width: .infinity, height: 75)
    }
}

struct CityTextView: View {
    var cityName: String
    var body: some View {
        VStack {
            Text(cityName)
                .font(.system(size: 15, weight: .medium, design: .default))
                .underline()
                .foregroundColor(.white)
        }.background(Color.orange)
        
    }
}

struct MainWeatherStatusView: View {
    var imageName: String
    var temp: String
    var date: String
    var description: String
    var cityName: String
    var body: some View {
        
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 30) {
                Text(date)
                    .bold()
                    .foregroundColor(.white)
                Text("\(temp)˚C")
                    .font(.system(size: 50, weight: .medium, design: .default))
                    .foregroundColor(.white)
                    .bold()
                CityTextView(cityName: cityName)
                
            }
            .background(Color.orange)
            
            
            VStack(spacing: 14) {
                Image(systemName: imageName)
                    .renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 120, height: 120)
                Text(description)
                    .font(.system(size: 15, weight: .medium, design: .default))
                    .foregroundColor(.white)
                
                
            }.frame(
                maxWidth: .infinity,
                alignment: .center
            )
            
        }   .padding()
        
            .frame(
                maxWidth: .infinity,
                alignment: .topLeading
            )
        
        
    }
}

