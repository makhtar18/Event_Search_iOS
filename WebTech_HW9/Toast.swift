//
//  Toast.swift
//  WebTech_HW9
//
//  Created by Mehvish Akhtar on 03/05/23.
//
import SwiftUI

struct Toast<Presenting>: View where Presenting: View {

    @Binding var isShowing: Bool
    let presenting: () -> Presenting
    let text: Text

    var body: some View {
        
        if self.isShowing {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                withAnimation {
                    self.isShowing = false
                }
            }
        }

        return GeometryReader { geometry in

            ZStack(alignment: .bottom) {

                self.presenting()
                    .blur(radius: self.isShowing ? 1 : 0)

                VStack {
                    self.text
                }
                .frame(width: geometry.size.width/1.5,
                       height: geometry.size.height / 9)
                .background(Color.secondary.colorInvert())
                .foregroundColor(Color.primary)
                .cornerRadius(10)
                .transition(.slide)
                .opacity(self.isShowing ? 1 : 0)

            }

        }

    }

}
extension View {

    func toast(isShowing: Binding<Bool>, text: Text) -> some View {
        Toast(isShowing: isShowing,
              presenting: { self },
              text: text)
    }

}

/*struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        @State var show = true
        SplashScreenView()
        .toast(isShowing: $show, text: Text("hello"))
    }
}*/
