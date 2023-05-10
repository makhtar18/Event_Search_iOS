//
//  FavoriteView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 02/05/23.
//

import SwiftUI
import Kingfisher

struct FavoriteView: View {
    @State var favResults: [[String]] = []
    @State var showfavTable = false
    @State var eventIdDict: [String:[String]] = [:]
    var color = #colorLiteral(red: 0.8311056495, green: 0, blue: 0.03866848722, alpha: 1)
    func deleteFavRow(offsets: IndexSet) {
        withAnimation {
            let index = offsets.first!
            for i in (index + 1)..<favResults.count{
                var str = Int(favResults[i][5])!-1
                print(str)
                favResults[i][5] = "\(str)"
                eventIdDict[favResults[i][4]] = favResults[i]
            }
            eventIdDict.removeValue(forKey: favResults[index][4])
            favResults.remove(at: index)
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(eventIdDict) {
                UserDefaults.standard.set(encoded, forKey: "favorites")
            }
            if(eventIdDict.count<1){
                showfavTable = false
            }
        }
    }
    var body: some View {
        VStack{
                if(showfavTable){
                    List{
                        ForEach(favResults, id: \.self) { favRow in
                            NavigationLink(destination: ThreeTabView(eventId: favRow[4], eventRow: favRow)) {
                                HStack {
                                    Text(favRow[0])
                                        .padding(0.5)
                                        .frame(width:100)
                                    Text(favRow[1])
                                        .lineLimit(2)
                                        .padding(0.5)
                                    Text(favRow[2])
                                        .padding(0.5)
                                    Text(favRow[3])
                                        .padding(0.5)
                                }
                            }
                        }
                        .onDelete(perform: deleteFavRow)
                    }
                }
                else {
                    Spacer()
                    Text("No favorites found")
                        .font(.title3)
                        .foregroundColor(Color(color))
                    Spacer()
                }
        }
        .navigationTitle("Favorites")
        .onAppear(){
            favResults = []
            showfavTable = false
            if let data = UserDefaults.standard.data(forKey: "favorites") {
                let decoder = JSONDecoder()
                if let decoded = try? decoder.decode([String:[String]].self, from: data) {
                    if(decoded.count>0){
                        showfavTable = true
                        eventIdDict = decoded
                        favResults = Array(repeating: [], count: decoded.count)
                    }
                    decoded.forEach { key, value in
                        print(value[2]+" "+value[5])
                        print(favResults.count)
                        let index = Int(value[5])!
                        favResults[index] = value
                    }
                }
            }
        }
    }
}

struct FavoriteView_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteView()
    }
}
