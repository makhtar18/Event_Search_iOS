//
//  VenueViewModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 02/05/23.
//

import Foundation

struct VenueResponseModel: Hashable, Codable{
    
    var address: String
    var showAddress: Bool
    var phoneNumber: String
    var showPhoneNumber: Bool
    var openHours: String
    var showOpenHours: Bool
    var generalRule: String
    var showGeneralRule: Bool
    var childRule: String
    var showChildRule: Bool
    var name: String
    var lat: String
    var long: String

}

class VenueViewModel: ObservableObject{
    @Published var urlString = "https://assignment8webtech.uw.r.appspot.com/getVenueDetails?venue=Comerica%20Park"
    @Published var venueResponseModel: VenueResponseModel = VenueResponseModel(address: "", showAddress: false, phoneNumber: "", showPhoneNumber: false, openHours: "", showOpenHours: false, generalRule: "", showGeneralRule: false, childRule: "", showChildRule: true, name: "", lat: "", long: "")
    
    func getData() async{
        print("Accessing \(urlString)")
        
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode(VenueResponseModel.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.venueResponseModel = VenueResponseModel(address: "", showAddress: false, phoneNumber: "", showPhoneNumber: false, openHours: "", showOpenHours: false, generalRule: "", showGeneralRule: false, childRule: "", showChildRule: true, name: "", lat: "", long: "")
                }
                return
            }
            DispatchQueue.main.async {
                self.venueResponseModel = returned
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}
