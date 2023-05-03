//
//  ArtistViewModel.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 30/04/23.
//

import Foundation

struct Images: Hashable, Codable{
    var height: Int
    var url: String
    var width: Int
}
struct Followers: Hashable, Codable{
    var total: Int
}
struct External_urls: Hashable, Codable{
    var spotify: String
}
struct MusicRelatedArtists: Hashable, Codable, Identifiable{
    var external_urls: External_urls
    var followers: Followers
    var name: String
    var popularity: Int
    var images: [Images]
    var id: String
}
struct SpotifyAlbumnResponse: Hashable, Codable{
    var images: [Images]
}
struct ArtistResponseModel: Hashable, Codable{
    
    var musicRelatedArtists: [MusicRelatedArtists]
    var spotifyAlbumnResponse: [String: [SpotifyAlbumnResponse]]
    
}

class ArtistViewModel: ObservableObject{
    var spotifyAuthTokenUrl = "https://assignment8webtech.uw.r.appspot.com/getSpotifyAuthToken"
    @Published var urlString = "https://assignment8webtech.uw.r.appspot.com/spotifyResults?musicRelatedArtists=P!NK,Brandi%20Carlile,Grouplove,KidCutUp"
    @Published var artistResponseModel: ArtistResponseModel = ArtistResponseModel(musicRelatedArtists: [], spotifyAlbumnResponse:[:])
    
    func getData() async{
        print("Accessing \(urlString)")
        guard let authUrl = URL(string: spotifyAuthTokenUrl) else {
            return
        }
        do{
            let(_,_) = try await URLSession.shared.data(from:authUrl)
            print("Auth token generated")
        }
        catch{
            print("Error in getting \(spotifyAuthTokenUrl)")
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        do{
            let(data,_) = try await URLSession.shared.data(from:url)
            guard let returned = try? JSONDecoder().decode(ArtistResponseModel.self, from: data) else {
                print("JSON ERROR: Could not decode returned JSON data")
                DispatchQueue.main.async {
                    self.artistResponseModel = ArtistResponseModel(musicRelatedArtists: [], spotifyAlbumnResponse:[:])
                }
                return
            }
            DispatchQueue.main.async {
                self.artistResponseModel = returned
            }
            print("JSON returned")
        }
        catch{
            print("Error in getting \(urlString)")
        }
    }
}
