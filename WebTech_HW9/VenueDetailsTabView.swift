//
//  VenueDetailsTabView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 29/04/23.
//

import SwiftUI

struct VenueDetailsTabView: View {
    @State var displayMaps = false
    var eventName: String
    var venueResponseModel: VenueResponseModel
    func showMaps(){
        displayMaps = true
    }
    var body: some View {
        VStack{
            Text(eventName)
                .font(.title2)
                .fontWeight(.bold)
                .multilineTextAlignment(.center)
                .lineLimit(2)
                .padding(.bottom,30)
            VStack{
                Text("Name")
                    .font(.title3)
                    .fontWeight(.bold)
                    .multilineTextAlignment(.center)
                Text(venueResponseModel.name)
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
            }
            .padding(.bottom,1)
            if(venueResponseModel.showAddress){
                VStack{
                    Text("Address")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text(venueResponseModel.address)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom,1)
            }
            if(venueResponseModel.showPhoneNumber){
                VStack{
                    Text("Phone Number")
                        .font(.title3)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.center)
                    Text(venueResponseModel.phoneNumber)
                        .multilineTextAlignment(.center)
                        .foregroundColor(.secondary)
                }
                .padding(.bottom,1.5)
            }
            if(venueResponseModel.showOpenHours){
                ScrollView {
                    VStack{
                        Text("Open Hours")
                            .font(.title3)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Text(venueResponseModel.openHours)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxHeight: 90)
                .padding(.bottom, 30)
            }
            if(venueResponseModel.showGeneralRule){
                ScrollView {
                    VStack{
                        Text("General Rule")
                            .font(.title3)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Text(venueResponseModel.generalRule)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxHeight: 90)
                .padding(.bottom, 5)
            }
            if(venueResponseModel.showChildRule){
                ScrollView {
                    VStack{
                        Text("Child Rule")
                            .font(.title3)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.center)
                        Text(venueResponseModel.childRule)
                            .multilineTextAlignment(.center)
                            .foregroundColor(.secondary)
                    }
                }
                .frame(maxHeight: 90)
            }
            Button(action: showMaps, label:{
                Text("Show venue on maps")
            })
            .sheet(isPresented: $displayMaps){
                MapView(lat: Double(venueResponseModel.lat)!, long: Double(venueResponseModel.long)!, venueName: venueResponseModel.name)
            }
            .frame(width:200, height: 50)
            .background(Color.red)
            .foregroundColor(Color.white)
            .cornerRadius(15)
            .buttonStyle(PlainButtonStyle())
            .padding(.top,20)
            Spacer()
        }
        .frame(alignment: .leading)
        .padding(.horizontal,20)
    }
}

struct VenueDetailsTabView_Previews: PreviewProvider {
    static var previews: some View {
        let eventName = "P!NK: Summer Carnival 2023"
        let venueResponseModel = VenueResponseModel(address: "2100 Woodward Ave, Detroit, Michigan", showAddress: true, phoneNumber: "(313) 983-6606", showPhoneNumber: true, openHours: "JOE LOUIS ARENA SUMMER HOURS (Memorial Day to Labor Day): Mon - Fri: 10am - 6pm Sat - Sun: Events only and times vary JOE LOUIS ARENA WINTER HOURS: Mon - Sat: 10am - 6pm Sunday: Events only and times vary", showOpenHours: true, generalRule: "There is a non-smoking policy except in designated areas of the concourse. Professional Cameras are not permitted. Recording devices are not permitted.", showGeneralRule: true, childRule: "Children 3 years old and younger are admitted free. They will not have a seat assigned and will need to sit on adult's lap.", showChildRule: true, name: "Comerica Park", lat: "42.338753", long: "-83.048487")
        VenueDetailsTabView(eventName: eventName, venueResponseModel: venueResponseModel)
    }
}
