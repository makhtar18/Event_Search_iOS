//
//  ResultsTableView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 28/04/23.
//

import SwiftUI
import Kingfisher

struct ResultsTableView: View {
    var resultRow: ResultsTableResponseModel
    var eventRow: [String]{
        return [resultRow.date, resultRow.event, resultRow.genre, resultRow.venue, resultRow.eventId]
    }
    var body: some View {
        NavigationLink(destination: ThreeTabView(eventId: resultRow.eventId, eventRow: eventRow)){
            HStack {
                Text(resultRow.date+"|"+resultRow.time)
                    .padding(0.5)
                    .foregroundColor(.secondary)
                    .frame(width: 80)
                KFImage(URL(string: resultRow.icon))
                    .resizable()
                    .frame(width: 70, height: 70)
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .padding(0.5)
                Text(resultRow.event)
                    .font(.headline)
                    .padding(0.5)
                    .frame(width: 80)
                    .lineLimit(3)
                Text(resultRow.venue)
                    .font(.headline)
                    .padding(0.5)
                    .foregroundColor(.secondary)
                    .lineLimit(3)
                .padding()
            }
            .frame(height: 100)
        }
    }
}

struct ResultsTableView_Previews: PreviewProvider {
    static var previews: some View {
        @State var resultTableRow = ResultsTableResponseModel(date: "2013-04-01", time: "16:00:00", icon: "https://yt3.googleusercontent.com/RNzGvruAX9d_qsOgZzen1qvSCEDg_Hta8kimglTlyB12_1nZGDa3edRxyDQMWFrKEvPZpsCt6Q=s900-c-k-c0x00ffffff-no-rj", event: "Twice", genre: "Music", venue: "Sofi Stadium", eventId: "vvG1OZ9pNPuVvv")
        ResultsTableView(resultRow: resultTableRow)
    }
}
