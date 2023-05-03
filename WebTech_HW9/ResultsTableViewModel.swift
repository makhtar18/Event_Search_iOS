//
//  ResultsTableViewModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 28/04/23.
//

import Foundation

struct ResultsTableResponseModel: Hashable, Codable{
    var date: String
    var time: String
    var icon: String
    var event: String
    var genre: String
    var venue: String
    var eventId: String
    
}
extension ResultsTableResponseModel: Identifiable {
  var id: String { eventId }
}

class ResultsTableViewModel: ObservableObject{
    @Published var urlString = "https://assignment8webtech.uw.r.appspot.com/resultsTable?keyword=&segmentId=&radius=10&geoPoint="
    @Published var resultTableResponse : [ResultsTableResponseModel] = []
    
    func getData() async{
        print("Accessing \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode([ResultsTableResponseModel].self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.resultTableResponse = []
                }
                return
            }
            DispatchQueue.main.async {
                self.resultTableResponse = returned
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}
