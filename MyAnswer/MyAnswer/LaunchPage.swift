//
//  LaunchPage.swift
//  MyAnswer
//
//  Created by Son Le on 19/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77510060/why-is-my-text-not-showing-up-on-my-simulation-screen
struct LaunchPage: View {
    var body: some View {
        NavigationView {
            GeometryReader { geo in
                ZStack {
                    Color.green.edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
                    ScrollView {
                        VStack {
                            HStack {
                                Spacer()
                                
                                NavigationLink(destination: GroupPage()) {
                                    Text("Groups")
                                        .font(.system(size: 16, weight:.bold))
                                        .foregroundColor(.primary)
                                        .frame(maxWidth: .infinity, alignment: .trailing)
                                }
                                .padding(.trailing, 20)
                            }
                            
                            Spacer()
                            
                            Image(systemName: "star")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
//                                .frame(width: 700, height: 500)
                                .frame(width: geo.size.width, height: geo.size.width * 1.5)
                                .offset(y:25)
                                .padding(.horizontal, 20)
                            
                            Spacer()
                                .frame(height: 100)
                        }
                    }
                    .frame(width: geo.size.width)
                }
            }
            .navigationBarHidden(false)
        }
    }
}

struct GroupPage: View{
    var body: some View {
        Text("Groups")
            .font(.largeTitle)
            .fontWeight(.bold)
            .foregroundColor(Color.green)
            .multilineTextAlignment(.center)
            .padding(/*@START_MENU_TOKEN@*/.all, 2.0)
            .frame(width: 200.0, height: 50.0)
            .navigationBarTitle("Group Page")
    }
}

struct LaunchPage_Previews: PreviewProvider {
    static var previews: some View{
        LaunchPage()
    }
}
