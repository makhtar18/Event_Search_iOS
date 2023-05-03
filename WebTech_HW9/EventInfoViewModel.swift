//
//  EventInfoViewModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 29/04/23.
//

import Foundation

struct EventInfoResponseModel: Hashable, Codable{
    
    var date : String
    var dateWithoutTime : String
    var artist : String
    var venue : String
    var genres : String
    var priceRanges : String
    var ticketStatus : String
    var buyTicketAt : String
    var seatMap : String
    var artists : [String]
    var musicRelatedArtists : [String]
    var eventName : String
    var error : String
    
}
extension EventInfoResponseModel: Identifiable {
  var id: String { buyTicketAt }
}

class EventInfoViewModel: ObservableObject{
    @Published var urlString = "https://assignment8webtech.uw.r.appspot.com/eventsInfo?eventId="
    @Published var eventInfoResponse : EventInfoResponseModel = EventInfoResponseModel(date: "",dateWithoutTime: "",artist: "",venue: "",genres: "",priceRanges: "",ticketStatus: "",buyTicketAt: "buyTicket1",seatMap: "",artists: [],musicRelatedArtists: [],eventName: "",error: "")
    
    func getData() async{
        print("Accessing \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode(EventInfoResponseModel.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.eventInfoResponse = EventInfoResponseModel(date: "",dateWithoutTime: "",artist: "",venue: "",genres: "",priceRanges: "",ticketStatus: "",buyTicketAt: "buyTicket1",seatMap: "",artists: [],musicRelatedArtists: [],eventName: "",error: "")
                }
                return
            }
            DispatchQueue.main.async {
                self.eventInfoResponse = returned
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}
