//
//  Splashscreen.swift
//  DeviceKast
//
//  Created by Burak Ocbe on 22/02/2023.
//

import SwiftUI

struct Splashscreen: View {
    @State private var isActive = false
    @State private var size = 0.8
    @State private var opacity = 0.5
    @ObservedObject var userViewModel = UserViewModel()

    var body: some View {
        if isActive {
            TabMenu(userList: userViewModel.sorted)
        } else {
            ZStack {
                Color("RoyalBlue")
                VStack {
                    VStack {
                        Image("icapps")
                            .resizable(resizingMode: .stretch)
                            .padding(.horizontal)
                            .foregroundColor(Color.white)
                            .aspectRatio(contentMode: .fit)
                        
                        if !isActive {
                            ProgressView()
                                .padding(.top, 100.0)
                                .scaleEffect(2.0)
                                .progressViewStyle(CircularProgressViewStyle(tint: .white))
                                
                        }
                    }
                    .scaleEffect(size)
                    .opacity(opacity)
                    .onAppear{
                        withAnimation(.easeIn(duration: 1.2)) {
                            self.size = 0.9
                            self.opacity = 1.0
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                            withAnimation {
                                print("Inside")
                                self.isActive = true
                            }
                        }
                    }
                }
            }.edgesIgnoringSafeArea(.all)
        }
    }
}


struct Splashscreen_Previews: PreviewProvider {
    static var previews: some View {
        Splashscreen()
    }
}
