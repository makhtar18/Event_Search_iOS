//
//  AutocompleteViewModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 27/04/23.
//

import Foundation

struct Attractions: Identifiable, Hashable, Codable{
    var id: String
    var name: String
}
struct Embedded: Hashable, Codable{
    var attractions: [Attractions]
}
struct Keywords: Hashable, Codable {
    var _embedded: Embedded
}

class AutocompleteViewModel: ObservableObject{

    let keyword = ""
    @Published var urlString = "https://assignment8webtech.uw.r.appspot.com/keywordAutocomplete?keyword="
    @Published var autoCompleteResults : [Attractions] = []
    
    func getData() async{
        print("Accessing \(urlString)")
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode(Keywords.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.autoCompleteResults = []
                }
                return
            }
            DispatchQueue.main.async {
                self.autoCompleteResults = returned._embedded.attractions
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}
