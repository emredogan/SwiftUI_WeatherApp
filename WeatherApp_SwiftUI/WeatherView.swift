//
//  ContentView.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 25/11/2021.
//

import SwiftUI
import GooglePlaces


struct WeatherView: View {
    @ObservedObject var viewModel: WeatherViewModel
    @State private var showPlaceSearch = false
    @State private var address = "Istanbul"
    @State private var coordinates = CLLocationCoordinate2D(latitude: 28, longitude: 28)
    
    var body: some View {
            ZStack {
                VStack (spacing: 0){
                    if showPlaceSearch {
                        PlacePickers(address: $address, coordinates: $coordinates, showPlaceSearch: $showPlaceSearch)
                    }
                    
                    
                    
                    HStack {
                        MainWeatherStatusView(imageName:  viewModel.mainWeather.weatherIcon, temp: viewModel.mainWeather.temperature, date: viewModel.mainWeather.date , description: viewModel.mainWeather.weatherDescription, cityName:  viewModel.mainWeather.cityName, showPlaceSearch: $showPlaceSearch)
                    }
                    .frame(width: nil, height: 250, alignment: .center)
                    .background(.orange)
                    
                    
                    List(viewModel.mainWeather.weatherList, id: \.id) { item in
                        WeatherDayView(dayOfWeek:item.date , imageName: item.icon, temp: Int(item.temp), nightTemp: Int(item.nightTemp), description: item.description)
                        
                    }
                    .listStyle(PlainListStyle())
                    
                }.frame(alignment: .topTrailing)
                
            }

            
            .onChange(of: coordinates) { value in
                print("CHANGED")
                viewModel.weatherService.makeCityDataRequest(forCoordinates: value)
                viewModel.weatherService.makeDataRequest(forCoordinates: value)
                
            }
            .onAppear(perform: viewModel.refresh)
        
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
        .listRowBackground(Color(red: 211 / 255, green: 211 / 255, blue: 211 / 255))
        .frame(width: nil, height: 75)
    }
}

struct CityTextView: View {
    var cityName: String
    @Binding var showPlaceSearch: Bool

    var body: some View {
        VStack {
            Text(cityName)
                .font(.system(size: 15, weight: .medium, design: .default))
                .underline()
                .foregroundColor(.white)
        }.background(Color.orange)
            .onTapGesture {
                print("TAPPED")
                withAnimation{
                    showPlaceSearch.toggle()
                                }
            
            }
        
    }
}

struct MainWeatherStatusView: View {
    var imageName: String
    var temp: String
    var date: String
    var description: String
    var cityName: String
    @Binding var showPlaceSearch: Bool
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
                CityTextView(cityName: cityName, showPlaceSearch: $showPlaceSearch)
                
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



extension CLLocationCoordinate2D: Equatable {}

public func ==(lhs: CLLocationCoordinate2D, rhs: CLLocationCoordinate2D) -> Bool {
    return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude
}


struct PlacePickers: UIViewControllerRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    @Environment(\.presentationMode) var presentationMode
    @Binding var address: String
    @Binding var coordinates: CLLocationCoordinate2D
    @Binding var showPlaceSearch: Bool


    
    
    func makeUIViewController(context: UIViewControllerRepresentableContext<PlacePickers>) -> GMSAutocompleteViewController {
        
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        
        
        let fields: GMSPlaceField = GMSPlaceField(rawValue: UInt(GMSPlaceField.name.rawValue) |
                                                  UInt(GMSPlaceField.coordinate.rawValue))
        autocompleteController.placeFields = fields
        
        let filter = GMSAutocompleteFilter()
        filter.type = .city
        autocompleteController.autocompleteFilter = filter
        return autocompleteController
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: UIViewControllerRepresentableContext<PlacePickers>) {
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, GMSAutocompleteViewControllerDelegate {
        
        var parent: PlacePickers
        
        init(_ parent: PlacePickers) {
            self.parent = parent
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            DispatchQueue.main.async {
                print(place.description.description as Any)
                self.parent.address =  place.name!
                self.parent.coordinates =  place.coordinate
                self.parent.presentationMode.wrappedValue.dismiss()
            }
            
            withAnimation{
                parent.showPlaceSearch.toggle()
                            }
            
            
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: Error) {
            print("Error: ", error.localizedDescription)
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss()
            withAnimation{
                parent.showPlaceSearch.toggle()
                            }
        }
        
    }
}




