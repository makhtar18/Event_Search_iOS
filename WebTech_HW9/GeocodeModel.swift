//
//  GeocodeModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 28/04/23.
//

import Foundation

class GeocodeModel: ObservableObject{
    @Published var urlString = "https://assignment8webtech.uw.r.appspot.com/geohash?lat=&long="
    @Published var geocode = ""
    
    func getData() async{
        print("Accessing \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode(String.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.geocode = ""
                }
                return
            }
            DispatchQueue.main.async {
                self.geocode = returned
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}

