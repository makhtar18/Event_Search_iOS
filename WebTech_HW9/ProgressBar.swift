//
//  ProgressBar.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 01/05/23.
//

import SwiftUI

struct ProgressBar: View {
    var progress: Double
    var progressValue: Double{
        return (progress/100)
    }
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 15.0)
                .opacity(0.3)
                .foregroundColor(Color.orange)
            
            Circle()
                .trim(from: 0.0, to: CGFloat(min(self.progressValue, 1.0)))
                .stroke(style: StrokeStyle(lineWidth: 15.0, lineJoin: .round))
                .foregroundColor(Color.orange)
            
            Text(String(format: "%.0f", min(self.progressValue, 1.0)*100.0))
                .font(.title3)
                .bold()
                .foregroundColor(Color.white)
        }
    }
}
   

struct ProgressBar_Previews: PreviewProvider {
    static var previews: some View {
        @State var progress:Double = 83
        ProgressBar(progress: progress)
    }
}
