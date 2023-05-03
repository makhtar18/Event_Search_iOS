//
//  EventInfoTabView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 29/04/23.
//

import SwiftUI
import Kingfisher

struct EventInfoTabView: View {
    var eventInfoResponse: EventInfoResponseModel
    @State var addedToFav: Bool = false
    var eventRow : [String]
    let ticketStatusColor = ["onsale": Color.green, "offsale":Color.red, "cancelled":Color.black, "postponed":Color.orange, "rescheduled":Color.orange]
    let ticketStatusText = ["onsale":"On Sale", "offsale":"Off Sale", "cancelled":"Cancelled", "postponed":"Postponed", "rescheduled":"Rescheduled"]
    @State var eventInfoObj : [String:[String]] = [:]
    var eventButtonColor: Color {
        return (addedToFav) ? Color.red :  Color.blue
    }
    var eventInfoButtonText: String {
        return (addedToFav) ? "Remove From Favorites" :  "Save Event"
    }
    func onAddRemoveFromFav(){
            var favObj = eventInfoObj
            if(addedToFav){
                favObj.removeValue(forKey: eventInfoResponse.id)
            }
            else{
                favObj[eventInfoResponse.id] = eventRow
            }
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(favObj) {
                UserDefaults.standard.set(encoded, forKey: "favorites")
            }
            addedToFav = !addedToFav
    }
  
    var body: some View {
            VStack{
                /*ScrollView() {
                    HStack{
                        Spacer()
                        Text(eventInfoResponse.eventName)
                            .font(.title)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .center)
                        Spacer()
                    }
                }*/
                Text(eventInfoResponse.eventName)
                    .font(.title)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                    .frame(alignment: .center)
                    .lineLimit(2)
                HStack{
                    VStack(alignment: .leading){
                        Text("Date")
                            .fontWeight(.bold)
                        Text(eventInfoResponse.dateWithoutTime)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Artist | Team")
                            .fontWeight(.bold)
                        Text(eventInfoResponse.artist)
                            .foregroundColor(.secondary)
                    }
                }.padding(1)
                HStack{
                    VStack(alignment: .leading){
                        Text("Venue")
                            .fontWeight(.bold)
                        Text(eventInfoResponse.venue)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing){
                        Text("Genre")
                            .fontWeight(.bold)
                        Text(eventInfoResponse.genres)
                            .foregroundColor(.secondary)
                    }
                }.padding(1)
                HStack{
                    VStack(alignment: .leading){
                        Text("Price Range")
                            .fontWeight(.bold)
                        Text(eventInfoResponse.priceRanges)
                            .foregroundColor(.secondary)
                    }
                    Spacer()
                    VStack(alignment: .trailing, spacing: 0){
                        Text("Ticket Status")
                            .fontWeight(.bold)
                        Text(ticketStatusText[eventInfoResponse.ticketStatus] ?? "")
                            .foregroundColor(Color.white)
                            .frame(minWidth: 80, minHeight: 30)
                            .background(Rectangle().fill(ticketStatusColor[eventInfoResponse.ticketStatus] ?? Color.green).cornerRadius(5))
                            .padding(.top,5)
                            
                            
                    }
                }.padding(1)
                
                Button(action: onAddRemoveFromFav, label:{
                    Text(eventInfoButtonText)
                        .padding(10)
                        .lineLimit(2)
                })
                .frame(width:110, height: 50)
                .background(eventButtonColor)
                .foregroundColor(Color.white)
                .cornerRadius(15)
                .buttonStyle(PlainButtonStyle())
                .padding(5)

                KFImage(URL(string: eventInfoResponse.seatMap))
                    .resizable()
                    .frame(width: 300, height: 250)
                    .padding(5)
                
                let buyTicketText = "[Ticketmaster]("+eventInfoResponse.buyTicketAt+")"
                Text("Buy Ticket At: ")
                    .fontWeight(.bold) +
                        Text(.init(buyTicketText))

                HStack{
                    Text("Share on: ")
                        .fontWeight(.bold)
                    Link(destination: URL(string: "https://www.facebook.com/sharer/sharer.php?u=\(eventInfoResponse.buyTicketAt)")!) {
                        VStack {
                            Image("f_logo_RGB-Blue_144")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                    Link(destination: URL(string: "https://twitter.com/intent/tweet?text=Check%20"+eventInfoResponse.eventName.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!+"%20on%20Ticketmaster.%0D%0A&url="+eventInfoResponse.buyTicketAt)!) {
                        VStack {
                            Image("Twitter social icons - circle - blue")
                                .resizable()
                                .frame(width: 40, height: 40)
                                .aspectRatio(contentMode: .fit)
                        }
                    }
                }.padding(1)
                
            }
            .padding(10)
            .onAppear(){
                if let data = UserDefaults.standard.data(forKey: "favorites") {
                    let decoder = JSONDecoder()
                    if var decoded = try? decoder.decode([String:[String]].self, from: data) {
                        if(decoded.count>0){
                            if(decoded[eventInfoResponse.id] != nil){
                            addedToFav = true
                            }
                        }
                        eventInfoObj = decoded
                    }
                }
            }
    }
}

struct EventInfoTabView_Previews: PreviewProvider {
    static var previews: some View {
        @State var eventInfoResponse = EventInfoResponseModel(date: "2023-08-16 18:30:00",dateWithoutTime: "2023-08-16",artist: "P!NK | Brandi Carlile | Grouplove | KidCutUp",venue: "Comerica Park",genres: "Music | Rock | Pop",priceRanges: "40.95 - 344.95 USD",ticketStatus: "onsale",buyTicketAt: "https://www.ticketmaster.com/pnk-summer-carnival-2023-detroit-michigan-08-16-2023/event/08005D68E5374041",seatMap: "https://maps.ticketmaster.com/maps/geometry/3/event/08005D68E5374041/staticImage?type=png&systemId=HOST",artists: ["P!NK","Brandi Carlile","Grouplove","KidCutUp"],musicRelatedArtists: ["P!NK","Brandi Carlile","Grouplove","KidCutUp"],eventName: "P!NK: Summer Carnival 2023",error: "")
        EventInfoTabView(eventInfoResponse: eventInfoResponse, eventRow: ["2013-04-01|16:00:00","https://yt3.googleusercontent.com/RNzGvruAX9d_qsOgZzen1qvSCEDg_Hta8kimglTlyB12_1nZGDa3edRxyDQMWFrKEvPZpsCt6Q=s900-c-k-c0x00ffffff-no-rj","Twice","Sofi Stadium"])
    }
}