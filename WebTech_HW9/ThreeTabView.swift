//
//  ThreeTabView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 29/04/23.
//

import SwiftUI

struct ThreeTabView: View {
    var eventId = ""
    var eventRow : [String]
    @State var isLoading:Bool = true
    @StateObject var eventInfo = EventInfoViewModel()
    @StateObject var artistInfo = ArtistViewModel()
    @StateObject var venueInfo = VenueViewModel()
    
    func getEventInfo() async{
        eventInfo.eventId = eventId
        eventInfo.urlString = "https://assignment8webtech.uw.r.appspot.com/eventsInfo?eventId="+eventId
        await eventInfo.getData()
    }
    func getMusicRelatedArtists() -> String {
        return eventInfo.eventInfoResponse.musicRelatedArtists.reduce("") { (result, artist) in
            return result.isEmpty ? artist : "\(result),\(artist)"
        }
    }
    func getArtistInfo() async{
        let musicRelatedArtists=getMusicRelatedArtists()
        artistInfo.urlString="https://assignment8webtech.uw.r.appspot.com/spotifyResults?musicRelatedArtists="+musicRelatedArtists.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        await artistInfo.getData()
    }
    
    func getVenueInfo() async{
        venueInfo.urlString="https://assignment8webtech.uw.r.appspot.com/getVenueDetails?venue="+eventInfo.eventInfoResponse.venue.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        await venueInfo.getData()
    }
    
    var body: some View {
        TabView {
            if(isLoading){
                ProgressView("Please wait...")
            }
            else {
                EventInfoTabView(eventInfoResponse: eventInfo.eventInfoResponse, eventRow: eventRow)
                    .tabItem{
                        Image(systemName: "text.bubble.fill")
                        Text("Events")
                    }
                
                ArtistsTabView(musicRelatedArtists: artistInfo.artistResponseModel.musicRelatedArtists, spotifyAlbumnImages: artistInfo.artistResponseModel.spotifyAlbumnResponse)
                    .tabItem{
                        Image(systemName: "guitars")
                        Text("Artist/Team")
                    }
                
                VenueDetailsTabView(eventName: eventInfo.eventInfoResponse.eventName, venueResponseModel: venueInfo.venueResponseModel)
                    .tabItem{
                        Image(systemName: "location.fill")
                        Text("Venue")
                    }
            }
        }
        .onAppear(){
            Task{
                await getEventInfo()
                await getArtistInfo()
                await getVenueInfo()
                isLoading = false
            }
        }
    }
}

struct ThreeTabView_Previews: PreviewProvider {
    static var previews: some View {
        @State var eventRow = ["2013-04-01|16:00:00","https://yt3.googleusercontent.com/RNzGvruAX9d_qsOgZzen1qvSCEDg_Hta8kimglTlyB12_1nZGDa3edRxyDQMWFrKEvPZpsCt6Q=s900-c-k-c0x00ffffff-no-rj","Twice","Sofi Stadium","vvG1IZ9KBiqNAT"]
        ThreeTabView(eventId: "vvG1IZ9KBiqNAT", eventRow: eventRow)
    }
}
