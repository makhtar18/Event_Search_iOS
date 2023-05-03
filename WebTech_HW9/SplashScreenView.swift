//
//  SplashScreenView.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 03/05/23.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var size = 1.0
    @State private var opacity = 0.5
    
    var body: some View {
        if(isActive){
            ContentView()
        }
        else {
            VStack{
                VStack{
                    Image("launchScreen")
                }
                .scaleEffect(size)
                .opacity(opacity)
                .onAppear{
                    withAnimation(.easeIn(duration: 1.5)){
                        self.size = 1.2
                        self.opacity = 1.0
                    }
                }
            }
            .onAppear{
                print("loading...")
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    print("loaded")
                    withAnimation{
                        self.isActive = true
                    }
                }
            }
        }
    }
}

struct SplashScreenView_Previews: PreviewProvider {
    static var previews: some View {
        SplashScreenView()
    }
}
