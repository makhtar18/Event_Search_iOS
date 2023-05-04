//
//  ContentView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 27/04/23.
//

import SwiftUI
    
struct ContentView: View {
    let categories = ["Default", "Music", "Sports", "Arts & Theatre", "Film", "Miscellaneus"]
    @State var keyword = ""
    @State var distance = "10"
    @State var category = "Default"
    @State var location = ""
    @State var autoDetectLocation = false
    @State var showAutocompleteSheet = false
    @State var showLocationTextField = true
    @State var noResult = false
    @State var showResultsTable = false
    @State var isResultsTableLoading = true
    @StateObject var locationModel = LocationModel()
    @StateObject var ipInfoModel = IpInfoModel()
    @StateObject var geocodeModel = GeocodeModel()
    @StateObject var resultsTableViewModel = ResultsTableViewModel()
    @State var spinnerId = 0

    var segmentIdDict = ["Music":"KZFzniwnSyZfZ7v7nJ", "Sports":"KZFzniwnSyZfZ7v7nE", "Arts & Theatre": "KZFzniwnSyZfZ7v7na", "Film":"KZFzniwnSyZfZ7v7nn","Miscellaneous":"KZFzniwnSyZfZ7v7n1","Default":""]

    
    var color = #colorLiteral(red: 0.8311056495, green: 0, blue: 0.03866848722, alpha: 1)

    var submitColor: Color {
        return (keyword.isEmpty || (location.isEmpty && !autoDetectLocation)) ? Color.gray :  Color.red
    }
    var setFavObj: Void{
        if UserDefaults.standard.data(forKey: "favorites") == nil {
            let obj:[String:[String]] = [:]
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(obj) {
                UserDefaults.standard.set(encoded, forKey: "favorites")
            }
        }
    }

    var body: some View {
        NavigationView{
            VStack(spacing: 0) {
                Form{
                    HStack {
                        Text("Keyword:").foregroundColor(.secondary)
                        Spacer()
                        TextField("Required", text:$keyword)
                            .onSubmit{
                                Task {
                                    showAutocompleteSheet = true
                                }
                            }
                            .sheet(isPresented: $showAutocompleteSheet){
                                AutocompleteView(selectedKeyword: $keyword)
                            }
                    }
                    HStack {
                        Text("Distance:").foregroundColor(.secondary)
                        Spacer()
                        /*TextField("10", value:$distance, format: .number)*/
                        TextField("10", text: $distance)
                            .keyboardType(.decimalPad)
                    }
                    Picker("Category:", selection:$category) {
                        ForEach(categories, id: \.self) {
                            Text($0)
                        }
                    }
                    .foregroundColor(.secondary)
                    .pickerStyle(MenuPickerStyle())
                    
                    if(showLocationTextField){
                        HStack {
                            Text("Location:").foregroundColor(.secondary)
                            Spacer()
                            TextField("Required", text:$location)
                        }
                    }
                    Toggle("Auto-detect my location",isOn: $autoDetectLocation).foregroundColor(.secondary)
                        .onChange(of: autoDetectLocation) { value in
                            if(value){
                                location=""
                                showLocationTextField = false
                            }
                            else {
                                showLocationTextField = true
                            }
                        }
                    HStack {
                        Spacer()
                        Button(action: onFormSubmit){
                            Text("Submit")
                        }
                        .frame(width:115, height: 50)
                        .background(submitColor)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        .buttonStyle(BorderlessButtonStyle())
                        .disabled(keyword.isEmpty || (location.isEmpty && !autoDetectLocation))
                        
                        Spacer()
                        Spacer()
                        
                        Button(action: onFormClear, label:{
                            Text("Clear")
                        })
                        .frame(width:115, height: 50)
                        .background(Color.blue)
                        .foregroundColor(Color.white)
                        .cornerRadius(8)
                        .buttonStyle(BorderlessButtonStyle())
                        Spacer()
                    }.padding(10)
                    
                    Section{
                        if(showResultsTable){
                            List{
                                Text("Results")
                                    .font(.title)
                                    .fontWeight(.bold)
                                if(isResultsTableLoading){
                                    HStack {
                                        Spacer()
                                        ProgressView("Please wait...")
                                            .id(spinnerId)
                                            .onAppear {
                                                spinnerId += 1
                                            }
                                            .frame(alignment: .center)
                                        Spacer()
                                    }
                                }
                                else {
                                    if(noResult){
                                        Text("No result available")
                                            .foregroundColor(
                                                Color(color)
                                            )
                                    }
                                    else {
                                        ForEach(resultsTableViewModel.resultTableResponse) {resultRow in
                                            ResultsTableView(resultRow : resultRow)
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
            .navigationTitle("Event Search")
            .toolbar{
                NavigationLink(destination: FavoriteView()) {
                    Image(systemName: "heart.circle")
                        .font(.system(size: 22))
                }
            }
        }
    }
    func onFormSubmit() {
        print("Submitting")
        isResultsTableLoading = true
        if(distance.isEmpty){
            distance="10"
            print(distance)
        }
        var lat = ""
        var long = ""
        let segmentId : String = segmentIdDict[category] ?? ""
        showResultsTable = true
        Task {
            if(autoDetectLocation){
                await ipInfoModel.getData()
                lat = ipInfoModel.ipInfoResponse.lat
                long = ipInfoModel.ipInfoResponse.lng
            }
            else{
                locationModel.urlString = "https://maps.googleapis.com/maps/api/geocode/json?key=AIzaSyCQtKQ4f9s_mMuNVY44fDCAfValQPITZiw&address="+location.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
                await locationModel.getData()
                lat = String(locationModel.geomResponse.lat)
                long = String(locationModel.geomResponse.lng)
                
            }
            geocodeModel.urlString = "https://assignment8webtech.uw.r.appspot.com/geohash?lat="+lat+"&long="+long
            await geocodeModel.getData()
            let url = "https://assignment8webtech.uw.r.appspot.com/resultsTable?segmentId=\(segmentId)&radius=\(distance)&geoPoint=\(geocodeModel.geocode)&keyword="+keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
            resultsTableViewModel.urlString = url
            await resultsTableViewModel.getData()
            if(resultsTableViewModel.resultTableResponse.count>0){
                noResult = false
            }
            else {
                noResult = true
            }
            isResultsTableLoading = false
        }
        
        
        
        
    }
    func onFormClear() {
        print("Clearing")
        keyword = ""
        distance = "10"
        category = "Default"
        location = ""
        autoDetectLocation = false
        showAutocompleteSheet = false
        showLocationTextField = true
        showResultsTable = false
        noResult = false
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

