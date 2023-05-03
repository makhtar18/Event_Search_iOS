//
//  LocationModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 28/04/23.
//

import Foundation
struct Location: Hashable, Codable{
    var lat: Double
    var lng: Double
}
struct Geometry: Codable{
    var location: Location
}
struct Result: Codable{
    var geometry: Geometry
}
struct LocationResponseModel: Codable{
    var results: [Result]
}

class LocationModel: ObservableObject{
    @Published var urlString = "https://maps.googleapis.com/maps/api/geocode/json?address=&key=AIzaSyCQtKQ4f9s_mMuNVY44fDCAfValQPITZiw"
    @Published var geomResponse : Location = Location(lat:0, lng:0)
    
    func getData() async{
        print("Accessing \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode(LocationResponseModel.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.geomResponse = Location(lat:0, lng:0)
                }
                return
            }
            DispatchQueue.main.async {
                self.geomResponse = returned.results[0].geometry.location
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}
