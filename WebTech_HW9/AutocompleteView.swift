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
    
    func autocomplete() async{
        autocompleteResponse.urlString = "https://assignment8webtech.uw.r.appspot.com/keywordAutocomplete?keyword="+selectedKeyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        await autocompleteResponse.getData()
    }
    
    var body: some View {
        NavigationView{
            List {
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
