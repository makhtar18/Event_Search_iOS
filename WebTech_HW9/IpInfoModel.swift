//
//  IpInfoModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 28/04/23.
//

import Foundation

struct IpInfoResponseModel: Codable{
    var loc: String
}

struct IpLocation: Codable{
    var lat: String
    var lng: String
}
class IpInfoModel: ObservableObject{
    var urlString = "https://ipinfo.io/?token=5b4b724fbcbf9e"
    var loc = ""
    @Published var ipInfoResponse : IpLocation = IpLocation(lat:"", lng:"")
    
    func getData() async{
        print("Accessing \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode(IpInfoResponseModel.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.loc = ""
                    self.ipInfoResponse = IpLocation(lat:"", lng:"")
                }
                return
            }
            DispatchQueue.main.async {
                self.loc = returned.loc
                let array = self.loc.components(separatedBy: ",")
                self.ipInfoResponse.lat = array[0]
                self.ipInfoResponse.lng = array[1]
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}
