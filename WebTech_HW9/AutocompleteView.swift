//
//  AutocompleteView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 28/04/23.
//

import SwiftUI

struct AutocompleteView: View {
    @Environment(\.dismiss) var dismiss
    @Binding var selectedKeyword : String
    @StateObject var autocompleteResponse = AutocompleteViewModel()
    @State private var isLoading = true
    
    func autocomplete() async{
        autocompleteResponse.urlString = "https://assignment8webtech.uw.r.appspot.com/keywordAutocomplete?keyword="+selectedKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        await autocompleteResponse.getData()
        isLoading = false
    }
    
    var body: some View {
        NavigationView{
            if(isLoading){
                ProgressView("loading...")
            }
            else {
                List {
                    if(autocompleteResponse.autoCompleteResults.count==0){
                        Text("No matching results found!")
                            .foregroundColor(Color(#colorLiteral(red: 0.8311056495, green: 0, blue: 0.03866848722, alpha: 1)))
                    }
                    ForEach(autocompleteResponse.autoCompleteResults) {result in
                        VStack {
                            Text("\(result.name)")
                                .onTapGesture {
                                    selectedKeyword = result.name
                                    dismiss()
                                }
                        }
                    }
                    
                }
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Text("Suggestions")
                            .font(.largeTitle.bold())
                            .accessibilityAddTraits(.isHeader)
                            .frame(width: 500, height: 75)
                            .background(Color.white)
                    }
                }
            }
            
        }.onAppear(){
            Task{
                await autocomplete()
            }
        }
        
    }
}

struct AutocompleteView_Previews: PreviewProvider {
    static var previews: some View {
        @State var selectedKeyword: String = ""
        AutocompleteView(selectedKeyword: $selectedKeyword)
    }
}
