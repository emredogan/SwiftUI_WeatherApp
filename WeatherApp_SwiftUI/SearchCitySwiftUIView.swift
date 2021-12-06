//
//  SearchCitySwiftUIView.swift
//  WeatherApp_SwiftUI
//
//  Created by Emre Dogan on 06/12/2021.
//

import SwiftUI
import GooglePlaces


struct SearchCitySwiftUIView: View {
    @State private var address = "Istanbul"
    @State private var coordinates = CLLocationCoordinate2D(latitude: 28, longitude: 28)
    var body: some View {
        PlacePicker(address: $address, coordinates: $coordinates)
    }
}

struct SearchCitySwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SearchCitySwiftUIView()
    }
}




//
//func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
//    DispatchQueue.main.async {
//        print(place.description.description as Any)
//        print(place.coordinate.latitude)
//        print(place.coordinate.longitude)
//
//        self.parent.coordinates = place.coordinate
//        self.parent.address =  place.name!
//        self.parent.presentationMode.wrappedValue.dismiss()
//    }
//}
