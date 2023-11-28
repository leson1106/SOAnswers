//
//  ContentView.swift
//  MyAnswer
//
//  Created by Son Le on 28/11/2023.
//

import SwiftUI

//https://stackoverflow.com/questions/77556596/how-to-stop-text-from-wiping-background-color-with-navigationstack
struct ContentView: View {
    @State private var text = ""
    var body: some View {
        NavigationStack {
            ZStack {
                BackgroundFillView()
                VStack {
                    TextField("Input here", text: $text)
                    Text("HELLO")
                }
            }
            .navigationBarTitle("TITLE")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
