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
    @State var distance = 10
    @State var category = "Default"
    @State var location = ""
    @State var autoDetectLocation = false
    @State var showAutocompleteSheet = false
    @State var showLocationTextField = true
    @State var noResult = false
    @State var showResultsTable = false
    var color = #colorLiteral(red: 0.8311056495, green: 0, blue: 0.03866848722, alpha: 1)

    var submitColor: Color {
        return (keyword.isEmpty || (location.isEmpty && !autoDetectLocation)) ? Color.gray :  Color.red
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
                        TextField("10", value:$distance, format: .number)
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
                        .buttonStyle(PlainButtonStyle())
                        Spacer()
                    }.padding(10)
                    
                }
                if(showResultsTable){
                    List{
                        Text("Results")
                            .font(.title)
                            .fontWeight(.bold)
                        if(noResult){
                            Text("No result available")
                                .foregroundColor(
                                    Color(color)
                                )
                        }
                        else {
                            
                        }
                    }
                }
            }
            .navigationTitle("Event Search")
        }
    }
    func onFormSubmit() {
        print("hello")
    }
    func onFormClear() {
        print("Clearing")
        keyword = ""
        distance = 10
        category = "Default"
        location = ""
        autoDetectLocation = false
        showAutocompleteSheet = false
        showLocationTextField = true
        var showResultsTable = false
        var noResult = false
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
